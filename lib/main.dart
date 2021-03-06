import 'package:easy_localization/easy_localization.dart';
import 'package:find_me_search_you/provider/get_user_data_provider.dart';
import 'package:find_me_search_you/provider/google_sign_in.dart';
import 'package:find_me_search_you/route.dart';
import 'package:find_me_search_you/view/page/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //비동기 main 설정시 사용
  WidgetsFlutterBinding.ensureInitialized();
  //firebase init
  await Firebase.initializeApp();
  // 언어 설정
  await EasyLocalization.ensureInitialized();
  // 화면 회전 방지
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('ko'),
      ],
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (_) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider<GetUserDataProvider>(
          create: (_) => GetUserDataProvider(),
        ),
      ],
      child: MaterialApp(
        // Easy Loaidng 추가.
        // 기기 font size 무시하고 고정
        builder: EasyLoading.init(
          builder: (context, child) {
            final data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: 1.0,
              ),
              child: child!,
            );
          },
        ),

        debugShowCheckedModeBanner: false,
        title: 'find me search you',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplashPage(), //
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
