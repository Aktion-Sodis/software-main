import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class InterventionRepository {
  static Future<amp.Intervention> getAmpInterventionByID(
      String interventionID) async {
    var interventions = await Amplify.DataStore.query(
        amp.Intervention.classType,
        where: amp.Intervention.ID.eq(interventionID));
    amp.Intervention toReturn = interventions.first;
    toReturn.copyWith(
      contents: relations,
      tags: ,
      levels: []
    )

  }

  static Future<amp.Intervention> _populate(amp.Intervention intervention) async {
    amp.Intervention toReturn = intervention;
    toReturn = toReturn.copyWith(
      contents: 
    );
  }
}
