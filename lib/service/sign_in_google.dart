import 'package:find_me_search_you/model/shared_preferences_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignIn {
  final googleSignIn = GoogleSignIn();
  final snsType = 'GOOGLE';

  late User user;

  Future<void> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user!;

      // shared preferences 에 sns type, id 넣기
      var prefs = SharedPreferences.getInstance();
      var sharedPreferences = await prefs;

      SharedPreferencesData().writeSnsId(sharedPreferences, user.uid);
      SharedPreferencesData().writeSnsType(sharedPreferences, snsType);
      // SharedPreferencesData()
      //     .writeUserName(sharedPreferences, _user!.displayName ?? '');
      // SharedPreferencesData().writeUserEmail(sharedPreferences, _user!.email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logout() async {
    // await googleSignIn.signOut();
    // await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
