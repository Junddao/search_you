import 'package:find_me_search_you/view/page/home/home_page.dart';
import 'package:find_me_search_you/view/page/login/login_page.dart';
import 'package:find_me_search_you/view/page/splash/root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;

    switch (settings.name) {
      case 'HomePage':
        return CupertinoPageRoute(builder: (_) => HomePage());

      case 'RootPage':
        return CupertinoPageRoute(builder: (_) => RootPage());

      case 'LoginPage':
        return CupertinoPageRoute(builder: (_) => LoginPage());

      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('${settings.name} 는 lib/route.dart에 정의 되지 않았습니다.'),
            ),
          ),
        );
    }
  }
}
