import 'package:find_me_search_you/provider/get_user_data_provider.dart';
import 'package:find_me_search_you/service/sign_in_google.dart';
import 'package:find_me_search_you/view/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      actions: [
        TextButton(
          onPressed: () async {
            await SignInGoogle().logout();

            Logger().d('sign Out');
            // await Navigator.of(context)
            //     .pushNamedAndRemoveUntil('RootPage', (route) => false);
          },
          child: Text(
            'logout',
            style: MTextStyles.bold18BlackRoboto,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    var userInfoData = context.read<GetUserDataProvider>().userInfoData;
    return Container(
      child: Center(child: Text(userInfoData.name)),
    );
  }
}
