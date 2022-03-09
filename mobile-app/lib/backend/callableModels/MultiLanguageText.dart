import 'package:mobile_app/models/ModelProvider.dart' as amp;
import 'package:mobile_app/frontend/strings.dart' as str;

class MultiLanguageText {
  late List<String> languageKeys;
  late List<String> languageTexts;

  String get text {
    if (languageKeys.contains(str.currentLanguage)) {
      int index = languageKeys.indexOf(str.currentLanguage);
      if (languageTexts[index] != "") {
        return languageTexts[index];
      } else {
        String toReturn = languageTexts.firstWhere((element) => element != "",
            orElse: () => "");
        return toReturn;
      }
    } else {
      String toReturn = languageTexts.firstWhere((element) => element != "",
          orElse: () => "");
      return toReturn;
    }
  }

  set text(String text) {
    if (languageKeys.contains(str.currentLanguage)) {
      int index = languageKeys.indexOf(str.currentLanguage);
      languageTexts[index] = text;
    } else {
      languageKeys.add(str.currentLanguage);
      languageTexts.add(text);
    }
  }

  MultiLanguageText({required this.languageKeys, required this.languageTexts});

  MultiLanguageText.fromString({String? string}) {
    languageKeys = [str.currentLanguage];
    languageTexts = [string ?? ""];
  }

  MultiLanguageText.fromAmplifyModel(amp.MultiLanguageText multiLanguageText) {
    languageKeys = multiLanguageText.languageKeys;
    languageTexts = multiLanguageText.languageTexts;
  }

  amp.MultiLanguageText toAmplifyModel() => amp.MultiLanguageText(
      languageKeys: languageKeys, languageTexts: languageTexts);
}
