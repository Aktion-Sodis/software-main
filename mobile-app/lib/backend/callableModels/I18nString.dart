import 'package:mobile_app/models/ModelProvider.dart' as amp;
import 'package:mobile_app/frontend/strings.dart' as str;

class I18nString {
  late List<String> languageKeys;
  late List<String?> languageTexts;

  String get text {
    if (languageKeys.contains(str.currentLanguage)) {
      int index = languageKeys.indexOf(str.currentLanguage);
      if (languageTexts[index] != null) {
        return languageTexts[index]!;
      } else {
        String toReturn = languageTexts.firstWhere((element) => element != null,
            orElse: () => "")!;
        return toReturn;
      }
    } else {
      String toReturn = languageTexts.firstWhere((element) => element != null,
          orElse: () => "")!;
      return toReturn;
    }
  }

  set text(String text) {
    if (languageKeys.contains(str.currentLanguage)) {
      int index = languageKeys.indexOf(str.currentLanguage);
      languageTexts[index] = text;
    } else {
      List<String> languageKeysToSet = List.from(languageKeys);
      List<String> languageTextesToSet = List.from(languageKeys);
      languageKeysToSet.add(str.currentLanguage);
      languageTextesToSet.add(text);
      languageKeys = languageKeysToSet;
      languageTexts = languageTextesToSet;
    }
  }

  I18nString({required this.languageKeys, required this.languageTexts});

  I18nString.fromString({String? string}) {
    languageKeys = [str.currentLanguage];
    languageTexts = [string];
  }

  I18nString.fromAmplifyModel(amp.I18nString I18nString) {
    languageKeys = I18nString.languageKeys;
    languageTexts = I18nString.languageTexts;
  }

  amp.I18nString toAmplifyModel() =>
      amp.I18nString(languageKeys: languageKeys, languageTexts: languageTexts);
}
