import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/repositories/ExecutedSurveyRepository.dart';
import 'package:mobile_app/backend/repositories/InterventionRepository.dart';
import 'package:mobile_app/backend/storage/dataStorePaths.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'UserRepository.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class AppliedInterventionRepository {
  static Future<List<amp.AppliedIntervention>>
      getAmpAppliedInterventionsByEntityID(String entityID) async {
    print("applied Interventions by Entity: $entityID");
    List<amp.AppliedIntervention> appliedIntervention =
        await Amplify.DataStore.query(amp.AppliedIntervention.classType,
            where: amp.AppliedIntervention.ENTITYAPPLIEDINTERVENTIONSID
                .eq(entityID));
    print("number: ${appliedIntervention.length}");

    return _populateList(appliedIntervention);
  }

  static Future<amp.AppliedIntervention> getAmpAppliedInterventionByID(
      String id) async {
    var result = await Amplify.DataStore.query(
        amp.AppliedIntervention.classType,
        where: amp.AppliedIntervention.ID.eq(id));
    return _populate(result.first);
  }

  static Future<String> createAppliedIntervention(
      AppliedIntervention appliedIntervention, Entity entity) async {
    print("inOriginal: " + entity.id!);
    appliedIntervention.id = appliedIntervention.id ?? UUID.getUUID();
    amp.AppliedIntervention ampModel = appliedIntervention.toAmplifyModel();
    print("inAmpModel1: " + (ampModel.entityAppliedInterventionsId ?? "null"));
    ampModel = ampModel.copyWith(entityAppliedInterventionsId: entity.id);
    print("inAmpModel2: " + (ampModel.entityAppliedInterventionsId ?? "null"));
    Amplify.DataStore.save(ampModel);
    return appliedIntervention.id!;
  }

  static Future updateAppliedIntervention(
      AppliedIntervention appliedIntervention, Entity entity) async {
    appliedIntervention.id = appliedIntervention.id ?? UUID.getUUID();
    amp.AppliedIntervention ampModel = appliedIntervention.toAmplifyModel();
    ampModel = ampModel.copyWith(entityAppliedInterventionsId: entity.id);
    Amplify.DataStore.save(ampModel);
  }

  static Future<amp.AppliedIntervention> appliedInterventionByExecutedSurvey(
      amp.ExecutedSurvey executedSurvey) async {
    print("applied intervention by executed survey");
    List<amp.AppliedIntervention> results = await Amplify.DataStore.query(
        amp.AppliedIntervention.classType,
        where: amp.AppliedIntervention.EXECUTEDSURVEYS
            .contains(executedSurvey.id));
    //todo: möglich, dass querying falsch
    return _populate(results.first, executedSurveys: []);
  }

  static Future<amp.AppliedIntervention> _populate(
      amp.AppliedIntervention appliedIntervention,
      {List<amp.ExecutedSurvey>? executedSurveys}) async {
//todo: hier liegt der fehler
    amp.Intervention intervention =
        await InterventionRepository.getAmpInterventionByID(
            appliedIntervention.appliedInterventionInterventionId);
    amp.User user = await UserRepository.getAmpUserByID(
        appliedIntervention.appliedInterventionWhoDidItId);
    print("intervention gotten by id");
    print("intervention: $intervention");
    print("user gotten by id");
    print("user: $user");
    amp.AppliedIntervention toReturn = appliedIntervention.copyWith(
        intervention: intervention, whoDidIt: user, executedSurveys: []);

    toReturn = toReturn.copyWith(
        executedSurveys: executedSurveys ??
            await ExecutedSurveyRepository.executedSurveysByAppliedIntervention(
                toReturn));

    return toReturn;
  }

  static Future<List<amp.AppliedIntervention>> _populateList(
          List<amp.AppliedIntervention> appliedInterventions) =>
      Future.wait(List.generate(appliedInterventions.length,
          (index) => _populate(appliedInterventions[index])));

  //todo: implement pic logic

  static SyncedFile appliedInterventionPic(
      AppliedIntervention appliedIntervention) {
    String path = dataStorePath(
        DataStorePaths.appliedInterventionPicPath, [appliedIntervention.id!]);
    return SyncedFile(path);
  }
}
