import 'package:find_me_search_you/model/user_info_data.dart';
import 'package:flutter/material.dart';

class GetUserDataProvider extends ChangeNotifier {
  late UserInfoData _userInfoData;

  UserInfoData get userInfoData => _userInfoData;
  set userInfoData(UserInfoData userInfoData) {
    _userInfoData = userInfoData;
  }
}
