import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/callableModels/I18nString.dart';
import 'package:mobile_app/backend/callableModels/Question.dart';
import 'package:mobile_app/backend/callableModels/SurveyTag.dart';

import 'package:mobile_app/models/ModelProvider.dart' as amp;

class Survey {
  String? id;
  late I18nString name_ml;
  late I18nString description_ml;
  Intervention? intervention;
  late List<Question> questions;
  late List<amp.SurveySurveyTagRelation> tagConnections;
  late bool archived;
  int? schemeVersion;
  DateTime? createdAt;
  DateTime? updatedAt;
  late SurveyType surveyType;

  String get name => name_ml.text;

  set name(String name) => name_ml.text = name;

  String get description => description_ml.text;

  set description(String description) => description_ml.text = description;

  List<SurveyTag> get tags => List.generate(tagConnections.length,
      (index) => SurveyTag.fromAmplifyModel(tagConnections[index].surveyTag));

  void addSurveyTag(SurveyTag surveyTag) {
    tagConnections.add(amp.SurveySurveyTagRelation(
        survey: toAmplifyModel(), surveyTag: surveyTag.toAmplifyModel()));
  }

  void updateSurveyTag(SurveyTag surveyTag) {
    int index = tagConnections
        .indexWhere((element) => element.surveyTag.id == surveyTag.id);
    if (index >= 0) {
      tagConnections[index] =
          tagConnections[index].copyWith(surveyTag: surveyTag.toAmplifyModel());
    } else {
      addSurveyTag(surveyTag);
    }
  }

  Question questionByID(String id) {
    return questions.firstWhere((element) => element.id == id);
  }

  Survey(
      {this.id,
      required this.name_ml,
      required this.description_ml,
      this.intervention,
      required this.questions,
      required this.tagConnections,
      this.schemeVersion,
      this.createdAt,
      this.updatedAt,
      required this.surveyType,
      this.archived = false});

  Survey.fromAmplifyModel(amp.Survey survey) {
    print(survey.intervention.toString());

    id = survey.id;
    name_ml = I18nString.fromAmplifyModel(survey.name);
    description_ml = I18nString.fromAmplifyModel(survey.description);
    intervention = survey.intervention != null
        ? Intervention.fromAmplifyModel(survey.intervention!)
        : null;
    questions = List.generate(survey.questions.length,
        (index) => Question.fromAmplifyModel(survey.questions[index]));
    tagConnections = survey.tags;
    schemeVersion = survey.schemeVersion;
    createdAt = survey.createdAt?.getDateTimeInUtc();
    updatedAt = survey.updatedAt?.getDateTimeInUtc();
    surveyType = surveyTypeFromAmplifySurveyType(
        survey.surveyType); //todo: change with theme change
    archived = survey.archived ?? false;
  }

  amp.Survey toAmplifyModel() {
    return amp.Survey(
        id: id,
        name: name_ml.toAmplifyModel(),
        description: description_ml.toAmplifyModel(),
        intervention: intervention?.toAmplifyModel(),
        surveyType: surveyTypeToAmplifySurveyType(surveyType),
        questions: List.generate(
            questions.length, (index) => questions[index].toAmplifyModel()),
        tags: tagConnections,
        schemeVersion: schemeVersion,
        archived: archived
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
