import 'package:find_me_search_you/model/user_info_data.dart';
import 'package:find_me_search_you/provider/get_user_data_provider.dart';
import 'package:find_me_search_you/view/page/home/home_page.dart';
import 'package:find_me_search_you/view/page/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            User user = snapshot.data;

            var userInfoData = UserInfoData.fromMap({
              'id': user.uid,
              'name': user.displayName,
              'mobile': user.phoneNumber,
              'email': user.displayName,
              'phothUrl': user.photoURL,
            });

            context.read<GetUserDataProvider>().userInfoData = userInfoData;

            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
