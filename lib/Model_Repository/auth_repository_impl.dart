import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_Repository/auth_repository.dart';
import 'package:fishauction_app/const/dataSource/datakey.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model_datahandler/datahandler_auth_impl.dart';

/* 로그인 기능을 담당하는 ViewModel. */
// 성공하면 1을  실패하면 2를 반환한다.

class AuthRepositoryImpl implements AuthRepository {

  final storage = const FlutterSecureStorage();
  @override
  Future<bool> doLogin(String uid, String upw) async {
    // DatahandlerHttpImpl datasource = DatahandlerHttpImpl();
    DatahandlerAuthImpl datasource = DatahandlerAuthImpl();
    Response? response = await datasource.postForLogin(uid, upw);
    // dataHandler 에서 request 하기 전에 오류 났을 경우 처리.
    if (response == null) {
      return false;
    }

    // response 처리하기 try 문
    try {
      List rbody = response.data;
      Headers rheader = response.headers;
      // String rheader =response.headers['access_token']!.first;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('accessToken', rheader['access_token']!.first);
      // await prefs.setString('refreshToken', rheader['refresh_token']!.first);
      // await prefs.setString('nickname', rbody[0]['nickname']!);
      // await prefs.setString('uid', uid);
      await storage.write(key: ACCESS_TOKEN_KEY,value:  rheader['access_token']!.first);
      await storage.write(key:RERESH_TOKEN_KEY,value:  rheader['refresh_token']!.first);
      await storage.write(key:NiCKNAME,value:  rbody[0]['nickname']!);
      await storage.write(key:USER_ID, value: uid);      
      
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return true;
  } // end of do Login Method

  Future<bool> checkToken() async {
    DatahandlerAuthImpl datasource = DatahandlerAuthImpl();
    bool checkToken = await datasource.checkToken();
    return checkToken;

  
  }
}
