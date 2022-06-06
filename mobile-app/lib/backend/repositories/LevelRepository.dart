import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/backend/storage/dataStorePaths.dart';
import 'package:mobile_app/backend/storage/image_synch.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class LevelRepository {
  static Future<List<Level>> getAllLevels() async {
    List<amp.Level> levels = await Amplify.DataStore.query(
      amp.Level.classType,
    );

    List<amp.Level> populated =
        await Future.wait(levels.map((e) => _populate(e)).toList());
    List<Level> toOrder =
        populated.map((e) => Level.fromAmplifyModel(e)).toList();

    // Sort in the ascending order
    List<Level> result = [];
    int rootIndex =
        toOrder.indexWhere((element) => element.parentLevelID == null);
    result.add(toOrder[rootIndex]);
    toOrder.removeAt(rootIndex);

    while (toOrder.isNotEmpty) {
      int childIndex = toOrder
          .indexWhere((element) => element.parentLevelID == result.last.id);
      result.add(toOrder[childIndex]);
      toOrder.removeAt(childIndex);
    }

    return Future.value(result);
  }

  static Future<amp.Level> getAmpLevelByID(String levelID) async {
    List<amp.Level> levels = await Amplify.DataStore.query(amp.Level.classType,
        where: amp.Level.ID.eq(levelID));

    return _populate(levels.first);
  }

  static Future<amp.Level> _populate(amp.Level level) async {
    amp.Level toReturn = level;
    toReturn = toReturn.copyWith(
        allowedInterventions: await levelInterventionRelationsByLevel(level));
    return toReturn;
  }

  static Future<List<amp.LevelInterventionRelation>>
      levelInterventionRelationsByLevel(amp.Level level) async {
    return Amplify.DataStore.query(amp.LevelInterventionRelation.classType,
        where: amp.LevelInterventionRelation.LEVEL.eq(level.id));
  }

  static SyncedFile getLevelPicFile(Level level) {
    String path = dataStorePath(DataStorePaths.levelPicPath, [level.id!]);
    return SyncedFile(path);
  }

  static SyncedFile getCustomDataPicFile(Level level, CustomData customData) {
    String path = dataStorePath(
        DataStorePaths.levelCustomDataPicPath, [level.id!, customData.id!]);
    return SyncedFile(path);
  }
}
