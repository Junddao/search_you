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
        ));
  }
}
