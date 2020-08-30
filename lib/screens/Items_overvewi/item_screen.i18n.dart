import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var _t = Translations("en_us") +
      {
        "en_us": "Item Card List C1",
        "ar_ar": "قائمة العناصر",
      };

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String, String> allVersions() => localizeAllVersions(this, _t);
}
