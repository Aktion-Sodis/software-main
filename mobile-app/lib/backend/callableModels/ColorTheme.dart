import 'package:mobile_app/models/ModelProvider.dart' as amp;

class ColorTheme {
  String? highlight;
  String? secondaryHighlight;
  String? backgroundOneLight;
  String? backgroundTwoLight;
  String? backgroundOneDark;
  String? backgroundTwoDark;

  ColorTheme(
      {this.highlight,
      this.secondaryHighlight,
      this.backgroundOneLight,
      this.backgroundTwoLight,
      this.backgroundOneDark,
      this.backgroundTwoDark});

  ColorTheme.fromAmplifyModel(amp.ColorTheme colorTheme) {
    highlight = colorTheme.highlight;
    secondaryHighlight = colorTheme.secondaryHighlight;
    backgroundOneLight = colorTheme.backgroundOneLight;
    backgroundTwoLight = colorTheme.backgroundTwoLight;
    backgroundOneDark = colorTheme.backgroundOneDark;
    backgroundTwoDark = colorTheme.backgroundTwoDark;
  }

  amp.ColorTheme toAmplifyModel() {
    return amp.ColorTheme(
        highlight: highlight,
        secondaryHighlight: secondaryHighlight,
        backgroundOneLight: backgroundOneLight,
        backgroundTwoLight: backgroundTwoLight,
        backgroundOneDark: backgroundOneDark,
        backgroundTwoDark: backgroundTwoDark);
  }
}
