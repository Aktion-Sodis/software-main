import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/Entity.dart';
import 'package:mobile_app/backend/repositories/AppliedInterventionRepository.dart';
import 'package:mobile_app/backend/repositories/LevelRepository.dart';
import 'package:mobile_app/backend/storage/dataStorePaths.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class EntityRepository {
  static const int batchSize = 15;

  static Future<List<amp.Entity>> getAllAmpEntities() async {
    return Amplify.DataStore.query<amp.Entity>(
      amp.Entity.classType,
    );
  }

  static Future<List<Entity>> getAllEntities({int? page}) async {
    return getEntities(page: page);
  }

  static Future<List<Entity>> getEntities(
      {int? page,
      bool byParentEntityID = false,
      String? parentEntityID,
      String? searchByName}) async {
    List<amp.Entity> allAmpEntities = await Amplify.DataStore.query(
        amp.Entity.classType,
        where: byParentEntityID && searchByName != null
            ? amp.Entity.PARENTENTITYID
                .eq(parentEntityID)
                .and(amp.Entity.NAME.contains(searchByName))
            : byParentEntityID
                ? amp.Entity.PARENTENTITYID.eq(parentEntityID)
                : searchByName != null
                    ? amp.Entity.NAME.contains(searchByName)
                    : null,
        pagination: page == null
            ? null
            : QueryPagination(page: page, limit: batchSize));
    List<amp.Entity> popluatedEntities =
        await _populateMultipleConnections(allAmpEntities);

    return List.generate(popluatedEntities.length,
        (index) => Entity.fromAmplifyModel(popluatedEntities[index]));
  }

  static Future<amp.Entity> ampEntityByID(String id) async {
    List<amp.Entity> results = await Amplify.DataStore.query(
        amp.Entity.classType,
        where: amp.Entity.ID.eq(id));
    return _populateConnections(results.first);
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
    String id = UUID.getUUID();
    entity.id = entity.id ?? id;
    Amplify.DataStore.save(
        entity.toAmplifyModel().copyWith(entityLevelId: entity.level.id));
    return entity.id!;
  }

  static Future updateEntity(Entity entity) async {
    Amplify.DataStore.save(
        entity.toAmplifyModel().copyWith(entityLevelId: entity.level.id));
  }

  static SyncedFile getEntityPic(Entity entity) {
    String path = dataStorePath(DataStorePaths.entityPicPath, [entity.id!]);
    return SyncedFile(path);
  }

  static SyncedFile getEntityPicByID(String entityId) {
    String path = dataStorePath(DataStorePaths.entityPicPath, [entityId]);
    return SyncedFile(path);
  }
}
