import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:mobile_app/models/ModelProvider.dart' as amp;

class LevelRepository {
  static Future<amp.Level> getAmpLevelByID(String levelID) async {
    List<amp.Level> levels = await Amplify.DataStore.query(amp.Level.classType,
        where: amp.Level.ID.eq(levelID));

    //todo: populate

    return levels.first;
  }
}
