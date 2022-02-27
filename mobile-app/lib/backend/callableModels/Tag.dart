import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Tag {
  String? id;
  late String text;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tag(
      {this.id,
      required this.text,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  Tag.fromAmplifyModel(amp.Tag tag) {
    id = tag.id;
    text = tag.text;
    schemeVersion = tag.schemeVersion;
    createdAt = tag.createdAt?.getDateTimeInUtc();
    updatedAt = tag.updatedAt?.getDateTimeInUtc();
  }

  amp.Tag toAmplifyModel() {
    return amp.Tag(text: text, id: id, schemeVersion: schemeVersion);
  }
}
