import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/all.dart';

class SignInKakao {
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
      print(token);
    } catch (e) {
      print('error on login: $e');
    }
  }
}
