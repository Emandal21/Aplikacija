import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization{
  final Locale locale;

  DemoLocalization(this.locale);

  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String> _localizedValues;

  Future<bool> load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    
    _localizedValues = mappedJson.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // getting translated values through key

  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<DemoLocalization> delegate = _DemoLocalizationDelegate();

}


class _DemoLocalizationDelegate extends LocalizationsDelegate<DemoLocalization> {

  const _DemoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    // just return if list of supported locales (languages) supports selected language
    return ['bs', 'de'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async{
    DemoLocalization localization = new DemoLocalization(locale);

    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;
  
}