import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/Question.dart';

class Survey {
  String id;
  String? name;
  String? description;
  Intervention? intervention;
  List<Question>? questions;
  List<String>? tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  SurveyType? surveyType;

  Survey(
      {required this.id,
      this.name,
      this.description,
      this.intervention,
      this.questions,
      this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt,
      this.surveyType});
}

enum SurveyType { INITIAL, DEFAULT }
