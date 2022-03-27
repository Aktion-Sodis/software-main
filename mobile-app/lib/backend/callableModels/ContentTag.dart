import 'package:mobile_app/backend/callableModels/I18nString.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class ContentTag {
  String? id;
  late I18nString text_ml;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  late List<amp.ContentContentTagRelation> contents;

  String get text => text_ml.text;

  set text(String text) => text_ml.text = text;

  ContentTag(
      {this.id,
      required this.text_ml,
      this.schemeVersion,
      required this.contents,
      this.createdAt,
      this.updatedAt});

  ContentTag.fromAmplifyModel(amp.ContentTag tag) {
    id = tag.id;
    text_ml = I18nString.fromAmplifyModel(tag.text);
    schemeVersion = tag.schemeVersion;
    createdAt = tag.createdAt?.getDateTimeInUtc();
    updatedAt = tag.updatedAt?.getDateTimeInUtc();
    contents = tag.contents;
  }

  amp.ContentTag toAmplifyModel() {
    return amp.ContentTag(
        text: text_ml.toAmplifyModel(),
        id: id,
        schemeVersion: schemeVersion,
        contents: contents);
  }
}
