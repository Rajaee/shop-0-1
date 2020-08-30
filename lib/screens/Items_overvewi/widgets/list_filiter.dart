import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';
import 'package:flutter/material.dart';

// Render an icon button that will launch the filter conditions UI sheet
// into the current scaffold.
class FilterConditionsLauncher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => FilterConditionsSheet(
            filterConditionsBloc: context.bloc<FilterConditionsBloc>(),
          ),
          elevation: 1,
        );
      },
    );
  }
}

// Hooks into the `FilterConditionsBloc` in order to render the filtering UI.
class FilterConditionsSheet extends StatelessWidget {
  // You must pass the FilterConditionsBloc to this widget, as the build
  // context will now belong to the Scaffold rendering the bottom sheet.
  final FilterConditionsBloc _filterConditionsBloc;

  const FilterConditionsSheet({@required filterConditionsBloc})
      : assert(filterConditionsBloc != null),
        _filterConditionsBloc = filterConditionsBloc;

  // Helper to avoid duplication in the child components and to avoid
  // having to pass the bloc down another level.
  // Handles toggling property/value pair in the filter conditions bloc.
  void _updateCondition(String property, String value, bool isChecked) {
    isChecked
        ? _filterConditionsBloc.add(AddCondition(
            property: property,
            value: value,
          ))
        : _filterConditionsBloc.add(RemoveCondition(
            property: property,
            value: value,
          ));
  }

  bool _isOptionActive(String property, String value) {
    return _filterConditionsBloc.isConditionActive(property, value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: BlocBuilder<FilterConditionsBloc, FilterConditionsState>(
        cubit: _filterConditionsBloc,
        builder: (_, state) {
          if (state is ConditionsInitialized) {
            // This could be further optimized by removing
            // the `FilterConditionGroup` all together and conditionally
            // rendering title or option rows.
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.availableConditions.length,
              itemBuilder: (_, index) {
                final condition =
                    state.availableConditions.entries.elementAt(index);
                return FilterConditionGroup(
                  condition: condition,
                  isOptionActive: _isOptionActive,
                  updateCondition: _updateCondition,
                );
              },
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}

// As we've built a UI around filtering, we need display-friendly
// labels for the underlying property names.
// This could easily be provided statically by the base item class instead.
const _filterPropertyLabelMap = {
  'brand': 'Brand',
};

// Essentially just a pass-through widget to simplify the rendering
// of each condition group.
class FilterConditionGroup extends StatelessWidget {
  final MapEntry<String, List<String>> condition;
  final Function(String property, String value) isOptionActive;
  final Function updateCondition;

  FilterConditionGroup({
    Key key,
    @required this.condition,
    @required this.isOptionActive,
    @required this.updateCondition,
  }) : super(key: key);

  @override
  Widget build(_) {
    return Container(
      key: ValueKey(condition.key),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _filterPropertyLabelMap[condition.key],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ...condition.value.map(
            (option) => CheckboxListTile(
              key: ValueKey(option),
              title: Text(option),
              value: isOptionActive(condition.key, option),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) =>
                  updateCondition(condition.key, option, isChecked),
            ),
          ),
        ],
      ),
    );
  }
}
