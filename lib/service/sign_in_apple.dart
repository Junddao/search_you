import 'package:find_me_search_you/model/shared_preferences_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInApple {
  late User user;
  final snsType = 'APPLE';
  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.jtb.searchyou.web',
            redirectUri: Uri.parse(
                'https://gregarious-atlantic-erigeron.glitch.me/callbacks/sign_in_with_apple')),
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      user = (await FirebaseAuth.instance.signInWithCredential(oauthCredential))
          .user!;
    } catch (e) {
      print(e.toString());
    }

    var prefs = SharedPreferences.getInstance();
    var sharedPreferences = await prefs;

    SharedPreferencesData().writeSnsId(sharedPreferences, user.uid);
    SharedPreferencesData().writeSnsType(sharedPreferences, snsType);
  }
}
