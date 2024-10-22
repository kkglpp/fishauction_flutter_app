import 'dart:convert';

import 'package:fishauction_app/Model_datahandler/datahandler_auth.dart';
import 'package:dio/dio.dart';
import 'package:fishauction_app/const/dataSource/datakey.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'static_for_datahandler.dart';

class DatahandlerAuthImpl implements DatahandlerAuth {
  final storage = const FlutterSecureStorage();

  final dio = Dio();
  String url = "${defaultURL}auth/";
  // String url = "https://final.oh-kang.kro.kr/auth/";
  // DatahandlerAuthImpl datasource = DatahandlerAuthImpl();


  @override
  Future<Response?> postForLogin(String uid, String upw) async {
    Map<String, String> data = {"id": uid, "password": upw};
    try {
      Response response = await dio.post(
        url,
        data: data,
        options:
        // options
        Options(
          contentType: Headers.jsonContentType,
        ),
      );
      return response;
    } catch (e) {
      // print("로그인 에러 발생 in dataHandler");
      // print(e);
      return null;
    }
  }
  
  @override
  Future<bool> checkToken() async{
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: RERESH_TOKEN_KEY);
    Map<String, String> header = {"authorization": refreshToken!};


    try{
      Response response = await dio.post(
        "$url/token",
        options: Options(
          headers: header,
        )
      );
      return true;
    }catch(e){
      return false;
    }
  }
  
  
}
