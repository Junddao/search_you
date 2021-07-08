import 'package:find_me_search_you/view/style/colors.dart';
import 'package:find_me_search_you/view/style/size_config.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // config 파일 읽어오고
    // shared preferences 가져오고

    // 업데이트 체크를 위한 패키지 정보 가져오고
    // device 정보 가져오고
    // 회원 가입 여부 확인하고 (sns type 가져와서 확인)
    // sign in 하고
    // 회원정보 가져오기

    checkLogin().then(
      (value) async {
        if (value == true) {
          _navigatorToHome();
        } else {
          _navigatorToLogin();
        }
      },
    );

    super.initState();
  }

  Future<bool> checkLogin() async {
    var result = false;

    await Future.delayed(Duration(milliseconds: 2000), () {});

    return result;
  }

  void _navigatorToLogin() {
    Navigator.of(context).pushNamed('RootPage');
  }

  void _navigatorToHome() {
    Navigator.of(context).pushNamed('RootPage');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Scaffold(
          backgroundColor: MColors.splash_background,
          body: Column(
            children: [_splashTopImage(flex: 1)],
          )),
    );
  }

  Widget _splashTopImage({required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.topLeft,
        child: Image.asset('assets/images/splash.png', fit: BoxFit.contain),
      ),
    );
  }
}
