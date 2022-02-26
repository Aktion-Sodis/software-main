import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/QuestionAnswer.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';
import 'package:mobile_app/backend/callableModels/User.dart';

class ExecutedSurvey {
  String id;
  AppliedIntervention? appliedIntervention;
  Survey? survey;
  User? whoExecutedIt;
  DateTime? date;
  Location? location;
  List<QuestionAnswer>? answers;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  ExecutedSurvey(
      {required this.id,
      this.appliedIntervention,
      this.survey,
      this.whoExecutedIt,
      this.date,
      this.location,
      this.answers,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});
}
