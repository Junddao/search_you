import 'package:find_me_search_you/view/page/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;

    switch (settings.name) {
      
      case 'HomePage':
        return CupertinoPageRoute(builder: (_) => HomePage());

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
