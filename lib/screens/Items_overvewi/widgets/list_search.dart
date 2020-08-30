import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_list_manager/flutter_bloc_list_manager.dart';

// Render an input that will funnel the value into the SearchQueryCubit.
class SearchInput extends StatelessWidget {
  @override
  Widget build(_) {
    return BlocBuilder<SearchQueryCubit, String>(
      builder: (context, state) {
        return Flexible(
          child: TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              labelText: 'Search',
            ),
            textInputAction: TextInputAction.search,
            onChanged: (value) =>
                context.bloc<SearchQueryCubit>().setQuery(value),
          ),
        );
      },
    );
  }
}
