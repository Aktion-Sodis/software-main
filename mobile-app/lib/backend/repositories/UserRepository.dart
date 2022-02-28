import 'package:mobile_app/models/ModelProvider.dart' as amp;
import 'package:mobile_app/backend/callableModels/CallableModels.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class UserRepository {
  Future<User?> getUserById(String userId) async {
    try {
      final List<amp.User> users = await Amplify.DataStore.query(
        amp.User.classType,
        where: amp.User.ID.eq(userId),
      );
      return users.isNotEmpty ? User.fromAmplifyModel(users.first) : null;
    } catch (e) {
      rethrow;
    }
  }

  Future createUser(User user) async {
    ///creates a user
    ///ID always has to be set as it should equal the authentication ID
    amp.User newUser = user.toAmplifyModel();
    await Amplify.DataStore.save(newUser);
  }
}
