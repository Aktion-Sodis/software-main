import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class EntityRepository {
  Future<List<Entity>> getAllEntities() async {
    List<amp.Entity> allAmpEntities = await Amplify.DataStore.query(
      amp.Entity.classType,
    );
    List<Entity> toReturn = [];
    for (amp.Entity amplifyEntity in allAmpEntities) {
      print(amplifyEntity.toJson());
    }
    return toReturn;
  }
}
