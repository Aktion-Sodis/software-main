import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/Intervention.dart';
import 'package:mobile_app/backend/repositories/SurveyRepository.dart';
import 'package:mobile_app/backend/storage/dataStorePaths.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class InterventionRepository {
  static Future<amp.Intervention> getAmpInterventionByID(
      String interventionID) async {
    try {
      var interventions = await Amplify.DataStore.query(
          amp.Intervention.classType,
          where: amp.Intervention.ID.eq(interventionID));
      amp.Intervention toReturn = interventions.first;
      print("returned intervention by id");
      return _populate(toReturn);
    } catch (e) {
      print("error in getting intervention by id");
      print(e.toString());
      var interventions = await Amplify.DataStore.query(
          amp.Intervention.classType,
          where: amp.Intervention.ID.eq(interventionID));
      amp.Intervention toReturn = interventions.first;
      print("returned intervention by id");
      return _populate(toReturn);
    }
  }

  static Future<List<Intervention>> getInterventionsByLevelConnections(
      List<amp.LevelInterventionRelation> relations) async {
    print("interventions to populate from connections: ${relations.length}");
    List<amp.Intervention> toWait = List.generate(
        relations.length, (index) => relations[index].intervention);
    var populated = await _populateList(toWait);
    return List.generate(populated.length,
        (index) => Intervention.fromAmplifyModel(populated[index]));
  }

  //todo: implement pic
  static String getInterventionIconPath(Intervention intervention) => "";
  static String getInterventionImagePath(Intervention intervention) => "";

  static Future<amp.Intervention?> getAmplifyInterventionBySurvey(
      amp.Survey survey) async {
    /*var interventions = await Amplify.DataStore.query(
        amp.Intervention.classType,
        where: amp.Intervention;*/
    return null;
    //return _populate(interventions.first);
    //todo: query könnte falsch sein
  }

  static Future<List<amp.Intervention>> _populateList(
      List<amp.Intervention> interventions) {
    List<Future<amp.Intervention>> toWait = List.generate(
        interventions.length, (index) => _populate(interventions[index]));
    return Future.wait(toWait);
  }

  static Future<amp.Intervention> _populate(
      amp.Intervention intervention) async {
    amp.Intervention toReturn = intervention;
    toReturn = toReturn.copyWith(
        contents:
            await interventionContentRelationsByInterventionID(intervention),
        tags: await interventionInterventionTagRelationsByInterventionID(
            intervention),
        levels: await levelInterventionRelationsByInterventionID(intervention),
        surveys:
            await SurveyRepository.getAmpSurveysByIntervention(intervention));
    return toReturn;
  }

  static Future<List<amp.InterventionContentRelation>>
      interventionContentRelationsByInterventionID(
          amp.Intervention intervention) async {
    return Amplify.DataStore.query(amp.InterventionContentRelation.classType,
        where:
            amp.InterventionContentRelation.INTERVENTION.eq(intervention.id));
  }

  static Future<List<amp.InterventionInterventionTagRelation>>
      interventionInterventionTagRelationsByInterventionID(
          amp.Intervention intervention) async {
    return Amplify.DataStore.query(
        amp.InterventionInterventionTagRelation.classType,
        where: amp.InterventionInterventionTagRelation.INTERVENTION
            .eq(intervention.id));
  }

  static Future<List<amp.LevelInterventionRelation>>
      levelInterventionRelationsByInterventionID(
          amp.Intervention intervention) async {
    return Amplify.DataStore.query(amp.LevelInterventionRelation.classType,
        where: amp.LevelInterventionRelation.INTERVENTION.eq(intervention.id));
  }

  static SyncedFile getInterventionPic(Intervention intervention) {
    String path =
        dataStorePath(DataStorePaths.interventionPicPath, [intervention.id!]);
    return SyncedFile(path);
  }
}
