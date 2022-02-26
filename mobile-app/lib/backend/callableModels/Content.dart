import 'package:mobile_app/backend/callableModels/Intervention.dart';

class Content {
  String id;
  String? name;
  String? description;
  List<Intervention>? interventions; //many to many -> maybe change
  List<String>? tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  Content(
      {required this.id,
      this.name,
      this.description,
      this.interventions,
      this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}
