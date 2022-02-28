///Implementierungsvorschlag @christoph
///eine klasse, über welche statische methoden/futures/variablen aufrufbar sind
///nötige Methoden/Futures/...
/// - Log in mit e-mail (am besten Future<String>) -> rückübergabe der erhaltenen ID
/// - Log in mit Telefonnummer (...) -> ... (muss ggf. noch in amplify hinterlegt werden -> im zweifel @CoachBenedetto fragen)
/// - Log out (am besten Future<bool>) -> rückgabe true wenn erfolgreich
/// - Aktuelle user id (Future<String>) -> wenn nicht eingeloggt null
/// - login status (Future<LoginStatus>) -> Enum für LoginStatus erstellen
/// - wir verwenden nicht das login ui von amplify zunächst; können wir uns allerdings gemeinsam mit den designern nochmal anschauen
/// - bei login immer an device erinnern
/// - bei logout device vergewssen

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  Future<String?> _getUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey.toString() == 'sub')
          .value;
      return userId;
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<String?> attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();

      return session.isSignedIn ? (await _getUserIdFromAttributes()) : null;
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  // todo: Verify how to implement "always remember device" on login.
  Future<String?> login({
    required String username,
    required String password,
  }) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username.trim(),
        password: password.trim(),
      );

      return result.isSignedIn ? (await _getUserIdFromAttributes()) : null;
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<String?> _loginWithWebUI(
    AuthProvider authProvider,
  ) async {
    try {
      SignInResult result =
          await Amplify.Auth.signInWithWebUI(provider: authProvider);
      return result.isSignedIn ? (await _getUserIdFromAttributes()) : null;
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<String?> loginWithGoogle() => _loginWithWebUI(AuthProvider.google);
  Future<String?> loginWithFacebook() => _loginWithWebUI(AuthProvider.facebook);
  Future<String?> loginWithApple() => _loginWithWebUI(AuthProvider.apple);

  // todo: verify how to
  Future<bool> signUp({
    required String username,
    required String password,
    String? email,
    String? phoneNumber,
  }) async {
    Map<CognitoUserAttributeKey, String> userAttributes = {};
    email ??= userAttributes[CognitoUserAttributeKey.email] = email!.trim();
    phoneNumber ??= userAttributes[CognitoUserAttributeKey.phoneNumber] =
        phoneNumber!.trim();

    final options = CognitoSignUpOptions(userAttributes: userAttributes);
    try {
      final result = await Amplify.Auth.signUp(
        username: username.trim(),
        password: password.trim(),
        options: options,
      );
      return result.isSignUpComplete;
    } on AuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  Future<bool> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username.trim(),
        confirmationCode: confirmationCode.trim(),
      );
      return result.isSignUpComplete;
    } on AuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  // todo: Verify how to implement "forgetting device" on sign out.
  Future<bool> signOut() async {
    try {
      await Amplify.Auth.signOut(
          options: const SignOutOptions(globalSignOut: true));
      return true;
    } catch (e) {
      debugPrint("Error on sign out:\n" + e.toString());
      return false;
    }
  }
}
