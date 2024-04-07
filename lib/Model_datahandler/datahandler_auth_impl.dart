import 'dart:convert';

import 'package:fishauction_app/Model_datahandler/datahandler_auth.dart';
import 'package:dio/dio.dart';

import 'staticforDatahandler.dart';

class DatahandlerAuthImpl implements DatahandlerAuth {
  final dio = Dio();
  String url = "${defaultURL}auth/";
  // String url = "https://final.oh-kang.kro.kr/auth/";
  // DatahandlerAuthImpl datasource = DatahandlerAuthImpl();

  @override
  Future<Response?> postForLogin(String uid, String upw) async {
    Map<String, String> data = {"id": uid, "password": upw};
    //   var headers = {
    //   'Content-Type' : 'application/json',
    //   'accept': 'application/json',
    // };
    //   var options = Options(
    //     headers: headers
    //   );
    
    try {
      print(url);
      Response response = await dio.post(
        url,
        data: data,
        options:
        // options
        Options(
          contentType: Headers.jsonContentType,
          extra: {'accept': 'application/json'},
        ),
      );
      return response;
    } catch (e) {
      print("로그인 에러 발생 in dataHandler");
      print(e);
      return null;
    }
  }
}
