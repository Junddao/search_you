import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:uuid/uuid.dart';

class SignInKakao {
  late User user;

  // Future<UserCredential> signInWithKakao() async {
  //   final clientState = Uuid().v4();
  //   final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
  //     'response_type': 'code',
  //     'client_id': 'f03d1bb980e5102a3df8722a9a53026f',
  //     'response_mode': 'form_post',
  //     'redirect_uri':
  //         'https://gregarious-atlantic-erigeron.glitch.me/callbacks/kakao/sign_in',
  //     'scope': 'account_email profile',
  //     'state': clientState,
  //   });

  //   final result = await FlutterWebAuth.authenticate(
  //       url: url.toString(),
  //       callbackUrlScheme: 'webauthcallback'); //"applink"//"signinwithapple"
  //   final body = Uri.parse(result).queryParameters;
  //   print(body['code']);

  //   final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token', {
  //     'grant_type': 'authorization_code',
  //     'client_id': 'f03d1bb980e5102a3df8722a9a53026f',
  //     'redirect_uri':
  //         'https://gregarious-atlantic-erigeron.glitch.me/callbacks/kakao/sign_in',
  //     'code': body['code'],
  //   });
  //   var responseTokens = await http.post(tokenUrl);
  //   Map<String, dynamic> bodys = json.decode(responseTokens.body);
  //   var response = await http.post(
  //       Uri.parse(
  //           'https://gregarious-atlantic-erigeron.glitch.me//callbacks/kakao/token'),
  //       body: {'accessToken': bodys['access_token']});
  //   return FirebaseAuth.instance.signInWithCustomToken(response.body);
  // }

  Future<void> signInWithKakao() async {
    KakaoContext.clientId = '8fb3f128735e3345ac3fa345b12e7d59';

    try {
      var isKakaoInstalled = await isKakaoTalkInstalled();
      String authCode;
      if (isKakaoInstalled) {
        authCode = await AuthCodeClient.instance.requestWithTalk();
      } else {
        authCode = await AuthCodeClient.instance.request();
      }
      var token = await AuthApi.instance.issueAccessToken(authCode);
      await AccessTokenStore.instance.toStore(token);
      print(token.accessToken);

      var response = await http.post(
          Uri.parse(
              'https://gregarious-atlantic-erigeron.glitch.me/callbacks/kakao/token'),
          body: {'accessToken': token.accessToken});
      user = (await FirebaseAuth.instance.signInWithCustomToken(response.body))
          .user!;
    } catch (e) {
      print('error on login: $e');
    }
  }
}
