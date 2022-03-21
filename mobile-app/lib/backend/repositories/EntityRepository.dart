import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/LevelRepository.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class EntityRepository {
  Future<List<Entity>> getAllEntities() async {
    List<amp.Entity> allAmpEntities = await Amplify.DataStore.query(
      amp.Entity.classType,
    );
    print("allAmpEntities: ${allAmpEntities.length}");
    List<amp.Entity> popluatedEntities =
        await _populateMultipleConnections(allAmpEntities);

    return List.generate(popluatedEntities.length,
        (index) => Entity.fromAmplifyModel(popluatedEntities[index]));
  }

  static Future<amp.Entity> _populateConnections(amp.Entity entity) async {
    amp.Entity amplifyEntity = entity;
    amplifyEntity = amplifyEntity.copyWith(
        level:
            await LevelRepository.getAmpLevelByID(amplifyEntity.entityLevelId),
        appliedInterventions: await AppliedInterventionRepository
            .getAmpAppliedInterventionsByEntityID(amplifyEntity.id));
    return amplifyEntity;
  }

  static Future<List<amp.Entity>> _populateMultipleConnections(
      List<amp.Entity> entities) {
    List<Future<amp.Entity>> populateFutures = List.generate(
        entities.length, (index) => _populateConnections(entities[index]));
    return Future.wait(populateFutures);
  }

  static Future<String> createEntity(Entity entity) async {
    String id = UUID().toString();
    entity.id = id;
    Amplify.DataStore.save(entity.toAmplifyModel());
    return id;
  }

  static Future updateEntity(Entity entity) async {
    Amplify.DataStore.save(entity.toAmplifyModel());
  }
}
