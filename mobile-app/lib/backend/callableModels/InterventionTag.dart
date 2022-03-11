import 'package:mobile_app/models/ModelProvider.dart' as amp;

class InterventionTag {
  String? id;
  late String text;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  InterventionTag(
      {this.id,
      required this.text,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  InterventionTag.fromAmplifyModel(amp.InterventionTag tag) {
    id = tag.id;
    text = tag.text;
    schemeVersion = tag.schemeVersion;
    createdAt = tag.createdAt?.getDateTimeInUtc();
    updatedAt = tag.updatedAt?.getDateTimeInUtc();
  }

  amp.InterventionTag toAmplifyModel() {
    return amp.InterventionTag(
        text: text, id: id, schemeVersion: schemeVersion);
  }
}
