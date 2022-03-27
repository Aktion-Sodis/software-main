import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:mobile_app/backend/callableModels/AppliedIntervention.dart';
import 'package:mobile_app/backend/callableModels/Location.dart';
import 'package:mobile_app/backend/callableModels/QuestionAnswer.dart';
import 'package:mobile_app/backend/callableModels/Survey.dart';
import 'package:mobile_app/backend/callableModels/User.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class ExecutedSurvey {
  String? id;
  late AppliedIntervention appliedIntervention;
  late Survey survey;
  late User whoExecutedIt;
  late DateTime date;
  Location? location;
  late List<QuestionAnswer> answers;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;

  ExecutedSurvey(
      {this.id,
      required this.appliedIntervention,
      required this.survey,
      required this.whoExecutedIt,
      required this.date,
      this.location,
      required this.answers,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt});

  ExecutedSurvey.fromAmplifyModel(amp.ExecutedSurvey executedSurvey) {
    id = executedSurvey.id;
    appliedIntervention = AppliedIntervention.fromAmplifyModel(
        executedSurvey.appliedIntervention);
    survey = Survey.fromAmplifyModel(executedSurvey.survey);
    whoExecutedIt = User.fromAmplifyModel(executedSurvey.whoExecutedIt);
    date = executedSurvey.date.getDateTimeInUtc();
    location = executedSurvey.location == null
        ? null
        : Location.fromAmplifyModel(executedSurvey.location!);
    answers = List.generate(
        executedSurvey.answers.length,
        (index) =>
            QuestionAnswer.fromAmplifyModel(executedSurvey.answers[index]));
    schemeVersion = executedSurvey.schemeVersion;
    createdAt = executedSurvey.createdAt?.getDateTimeInUtc();
    updatedAt = executedSurvey.updatedAt?.getDateTimeInUtc();
  }

  amp.ExecutedSurvey toAmplifyModel() {
    return amp.ExecutedSurvey(
      id: id,
      appliedIntervention: appliedIntervention.toAmplifyModel(),
      survey: survey.toAmplifyModel(),
      whoExecutedIt: whoExecutedIt.toAmplifyModel(),
      date: TemporalDateTime(date),
      location: location?.toAmplifyModel(),
      answers: List.generate(
          answers.length, (index) => answers[index].toAmplifyModel()),
      schemeVersion: schemeVersion,
      executedSurveySurveyId: survey.id!,
      executedSurveyWhoExecutedItId: whoExecutedIt.id!,
    );
  }
}
