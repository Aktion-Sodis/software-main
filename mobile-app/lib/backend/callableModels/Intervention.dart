import 'package:mobile_app/backend/callableModels/Content.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';

class Intervention {
  String id;
  String? name;
  String? description;
  InterventionType? interventionType;
  List<Content>? contents;
  List<Survey>? surveys;
  List<String>? tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Intervention(
      {required this.id,
      this.name,
      this.description,
      this.interventionType,
      this.contents,
      this.surveys,
      this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}

enum InterventionType { TECHNOLOGY, EDUCATION }
