import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Marking {
  late double x;
  late double y;
  late double rx;
  late double ry;
  late String text;

  Marking(
      {required this.x,
      required this.y,
      required this.rx,
      required this.ry,
      required this.text});

  amp.Marking toAmplifyModel() =>
      amp.Marking(x: x, y: y, rx: rx, ry: ry, text: text);

  Marking.fromAmplifyModel(amp.Marking marking) {
    x = marking.x;
    y = marking.y;
    rx = marking.rx;
    ry = marking.ry;
    text = marking.text;
  }
}
