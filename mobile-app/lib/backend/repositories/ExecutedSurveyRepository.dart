import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/backend/repositories/UserRepository.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class ExecutedSurveyRepository {
  static Future<ExecutedSurvey> executedSurveyByID(
      String executedSurveyID) async {
    amp.ExecutedSurvey executedSurvey =
        await ampExecutedSurveyByID(executedSurveyID);
    return ExecutedSurvey.fromAmplifyModel(executedSurvey);
  }

  static Future<amp.ExecutedSurvey> ampExecutedSurveyByID(
      String executedSurveyID) async {
    var results = await Amplify.DataStore.query(amp.ExecutedSurvey.classType,
        where: amp.ExecutedSurvey.ID.eq(executedSurveyID));
    return _populate(results.first);
  }

  static Future<List<amp.ExecutedSurvey>> executedSurveysByAppliedIntervention(
      amp.AppliedIntervention appliedIntervention) async {
    List<amp.ExecutedSurvey> toReturn = await Amplify.DataStore.query(
        amp.ExecutedSurvey.classType,
        where:
            amp.ExecutedSurvey.APPLIEDINTERVENTION.eq(appliedIntervention.id));
    return _populateList(toReturn, appliedIntervention: appliedIntervention);
  }

  static Future<amp.ExecutedSurvey> _populate(amp.ExecutedSurvey executedSurvey,
      {amp.AppliedIntervention? appliedIntervention}) async {
    amp.ExecutedSurvey toReturn = executedSurvey;
    executedSurvey.copyWith(
        appliedIntervention: appliedIntervention ??
            await AppliedInterventionRepository
                .appliedInterventionByExecutedSurvey(executedSurvey),
        whoExecutedIt: await UserRepository.getAmpUserByID(
            toReturn.executedSurveyWhoExecutedItId),
        survey: await SurveyRepository.getAmpSurveyByID(
            toReturn.executedSurveySurveyId));
    return toReturn;
  }

  static Future<List<amp.ExecutedSurvey>> _populateList(
      List<amp.ExecutedSurvey> executedSurveys,
      {amp.AppliedIntervention? appliedIntervention}) {
    return Future.wait(List.generate(
        executedSurveys.length,
        (index) => _populate(executedSurveys[index],
            appliedIntervention: appliedIntervention)));
  }
}
