import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/repositories/InterventionRepository.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;
import 'package:mobile_app/backend/callableModels/CallableModels.dart';

class SurveyRepository {
  static Future<Survey> getSurveyByID(String surveyID) async {
    amp.Survey survey = await getAmpSurveyByID(surveyID);
    return Survey.fromAmplifyModel(survey);
  }

  static Future<amp.Survey> getAmpSurveyByID(String surveyID) async {
    List<amp.Survey> results = await Amplify.DataStore.query(
        amp.Survey.classType,
        where: amp.Survey.ID.eq(surveyID));
    return _populate(results.first);
  }

  static Future<List<amp.Survey>> getAmpSurveysByIntervention(
      amp.Intervention intervention) async {
    var results = await Amplify.DataStore.query(amp.Survey.classType,
        where: amp.Survey.INTERVENTION.eq(intervention.id));
    return _populateList(results);
  }

  static Future<amp.Survey> _populate(amp.Survey survey,
      {amp.Intervention? intervention}) async {
    amp.Survey toReturn = survey;
    toReturn = toReturn.copyWith(
        intervention: intervention ??
            await InterventionRepository.getAmplifyInterventionBySurvey(survey),
        tags: await surveySurveyTagRelationsBySurvey(survey));
    return toReturn;
  }

  static Future<List<amp.Survey>> _populateList(List<amp.Survey> surveys,
      {amp.Intervention? intervention}) {
    return Future.wait(
        List.generate(surveys.length, (index) => _populate(surveys[index])));
  }

  static Future<List<amp.SurveySurveyTagRelation>>
      surveySurveyTagRelationsBySurvey(amp.Survey survey) async {
    return Amplify.DataStore.query(amp.SurveySurveyTagRelation.classType,
        where: amp.SurveySurveyTagRelation.SURVEY.eq(survey));
  }
}
