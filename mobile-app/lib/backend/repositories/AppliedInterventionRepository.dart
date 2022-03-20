import 'package:amplify_flutter/amplify_flutter.dart';
import 'UserRepository.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class AppliedInterventionRepository {
  static Future<List<amp.AppliedIntervention>>
      getAmpAppliedInterventionsByEntityID(String entityID) async {
    return Amplify.DataStore.query(amp.AppliedIntervention.classType,
        where:
            amp.AppliedIntervention.ENTITYAPPLIEDINTERVENTIONSID.eq(entityID));
  }

  static Future<amp.AppliedIntervention> _populateConnections(
      amp.AppliedIntervention appliedIntervention) async {
    amp.AppliedIntervention toReturn = appliedIntervention.copyWith(
      whoDidIt: await UserRepository.getAmpUserByID(appliedIntervention.appliedInterventionWhoDidItId),
      intervention:  await 
    );
  }
}
