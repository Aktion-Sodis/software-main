import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/Question.dart';
import 'package:mobile_app/backend/callableModels/Tag.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Survey {
  String? id;
  late String name;
  String? description;
  Intervention? intervention;
  late List<Question> questions;
  late List<Tag> tags;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  late SurveyType surveyType;

  Survey(
      {this.id,
      required this.name,
      this.description,
      this.intervention,
      required this.questions,
      required this.tags,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt,
      required this.surveyType});

  Survey.fromAmplifyModel(amp.Survey survey) {
    id = survey.id;
    name = survey.name;
    description = survey.description;
    intervention = survey.intervention != null
        ? Intervention.fromAmplifyModel(survey.intervention!)
        : null;
    questions = List.generate(survey.questions.length,
        (index) => Question.fromAmplifyModel(survey.questions[index]));
    tags = List.generate(survey.tags.length,
        (index) => Tag.fromAmplifyModel(survey.tags[index]));
    schemeVersion = survey.schemeVersion;
    createdAt = survey.createdAt?.getDateTimeInUtc();
    updatedAt = survey.updatedAt?.getDateTimeInUtc();
    surveyType = surveyTypeFromAmplifySurveyType(
        survey.surveyType); //todo: change with theme change
  }

  amp.Survey toAmplifyModel() {
    return amp.Survey(
      id: id,
      name: name,
      description: description,
      intervention: intervention?.toAmplifyModel(),
      surveyType: surveyTypeToAmplifySurveyType(surveyType),
      questions: List.generate(
          questions.length, (index) => questions[index].toAmplifyModel()),
      tags: List.generate(tags.length, (index) => tags[index].toAmplifyModel()),
      schemeVersion: schemeVersion,
      //todo: missing survey type
    );
  }
}

enum SurveyType { INITIAL, DEFAULT }

SurveyType surveyTypeFromAmplifySurveyType(amp.SurveyType surveyType) {
  switch (surveyType) {
    case amp.SurveyType.INITIAL:
      return SurveyType.INITIAL;
      break;
    case amp.SurveyType.DEFAULT:
      return SurveyType.DEFAULT;
      break;
  }
}

amp.SurveyType surveyTypeToAmplifySurveyType(SurveyType surveyType) {
  switch (surveyType) {
    case SurveyType.INITIAL:
      return amp.SurveyType.INITIAL;
      break;
    case SurveyType.DEFAULT:
      return amp.SurveyType.DEFAULT;
      break;
  }
}
