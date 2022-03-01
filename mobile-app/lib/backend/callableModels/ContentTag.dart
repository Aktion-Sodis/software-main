import 'package:mobile_app/models/ModelProvider.dart' as amp;

class ContentTag {
  String? id;
  late String text;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  ContentTag(
      {this.id,
      required this.text,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  ContentTag.fromAmplifyModel(amp.ContentTag tag) {
    id = tag.id;
    text = tag.text;
    schemeVersion = tag.schemeVersion;
    createdAt = tag.createdAt?.getDateTimeInUtc();
    updatedAt = tag.updatedAt?.getDateTimeInUtc();
  }

  amp.ContentTag toAmplifyModel() {
    return amp.ContentTag(text: text, id: id, schemeVersion: schemeVersion);
  }
}
