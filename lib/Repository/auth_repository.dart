import 'dart:convert';

import 'package:fishauction_app/DataSource/datasource_impl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* 로그인 기능을 담당하는 ViewModel. */
// 성공하면 1을  실패하면 2를 반환한다.

class AuthRepository {
  Future<bool> doLogin(String uid, String upw) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    Map<String, String>? postdata = {"id": uid, "password": upw};
    var response =
        await DataSourceImpl().post("auth/", postdata, headers: headers);

    try {
      if (response.statusCode == 200) {
        var rheader = response.headers;
        var rbody = json.decode(utf8.decode(response.bodyBytes));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', rheader['access_token']);
        await prefs.setString('refreshToken', rheader['refresh_token']);
        await prefs.setString('nickname', rbody[0]['nickname']);
        await prefs.setString('uid', uid);
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return true;
  }
}
