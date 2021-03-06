import 'dart:io';

import 'package:find_me_search_you/generated/locale_keys.g.dart';
import 'package:find_me_search_you/model/shared_preferences_data.dart';
import 'package:find_me_search_you/model/social_login_data.dart';
import 'package:find_me_search_you/model/user_info_data.dart';
import 'package:find_me_search_you/provider/get_user_data_provider.dart';
import 'package:find_me_search_you/provider/google_sign_in.dart';
import 'package:find_me_search_you/view/style/colors.dart';
import 'package:find_me_search_you/view/style/size_config.dart';
import 'package:find_me_search_you/view/style/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_socialLoginHeader(), _socialLoginListView()],
      ),
    );
  }

  void _onClickKakaoLogin() {
    print('[${runtimeType.toString()} : _onClickKakaoLogin');
    // var messageSignInKakao = MessageSignInKakao();
    // sendMessage(messageSignInKakao);
  }

  void _onClickGoogleLogin() async {
    print('[${runtimeType.toString()} : _onClickGoogleLogin');
    var provider = context.read<GoogleSignInProvider>();
    await provider.googleLogin();

    var userInfoData = UserInfoData.fromMap({
      'id': provider.user.uid,
      'name': provider.user.displayName!,
      'email': provider.user.email,
      'phothUrl': provider.user.photoURL!,
      'mobile': provider.user.phoneNumber,
    });

    context.read<GetUserDataProvider>().userInfoData = userInfoData;
  }

  void _onClickAppleLogin() {
    print('[${runtimeType.toString()} : _onClickAppleLogin');
  }

  Widget _socialLoginHeader() {
    return Container(
      width: SizeConfig.screenWidth,
      height: 190,
      color: MColors.white_four,
      padding: EdgeInsets.fromLTRB(35, 30, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(LocaleKeys.text_easy.tr(),
                  style: MTextStyles.bold31BlackNanoSans),
              Text(LocaleKeys.text_login.tr(),
                  style: MTextStyles.bold31BlackNanoSans),
            ],
          )
        ],
      ),
    );
  }

  Widget _socialLoginListView() {
    var socialList = [
      SocialLoginData(
          'KAKAO', 'assets/images/img_kakao.png', MColors.black_russian),
      SocialLoginData(
          'GOOGLE', 'assets/images/img_google.png', MColors.royal_blue)
    ];

    if (Platform.isIOS) {
      socialList.add(SocialLoginData(
          'APPLE', 'assets/images/img_apple.png', MColors.black));
    }

    return Expanded(
      flex: 1,
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          itemCount: socialList.length,
          itemBuilder: (BuildContext context, int index) {
            return _socialLoginTile(socialList[index]);
          }),
    );
  }

  Widget _socialLoginTile(SocialLoginData item) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(35, 14, 35, 14),
      leading: _icon(item.iconUrl),
      title: _title(item.text, item.color),
      trailing: Icon(Icons.keyboard_arrow_right_rounded),
      onTap: () {
        switch (item.text) {
          case 'KAKAO':
            {
              _onClickKakaoLogin();
              break;
            }

          case 'GOOGLE':
            {
              _onClickGoogleLogin();
              break;
            }

          case 'APPLE':
            {
              _onClickAppleLogin();
              break;
            }
        }
      },
    );
  }

  Widget _icon(String iconUrl) {
    return Container(
        constraints: BoxConstraints.tightFor(width: 46.0),
        child: Image.asset(
          iconUrl,
          fit: BoxFit.fitHeight,
        ));
  }

  Widget _title(String text, Color color) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      child: Text(text, style: MTextStyles.bold18BlackRoboto),
    );
  }
}
