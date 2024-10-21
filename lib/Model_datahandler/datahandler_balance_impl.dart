import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_datahandler/static_for_datahandler.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'datahandler_balance.dart';

class DatahandlerBalanceImpl implements DatahandlerBalance {
  Dio dio = Dio();
  String url = "$defaultURL/balance/";

  //포인트 충전하기
  @override
  Future<String?> postForChargePoints(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken'); // header에 들어갈 accesstoken
    // print(accessToken);
    var headers = {
      'accept': 'application/json',
      'Authorization': "Bearer $accessToken"
    }; //contenttype 이외의 header
    Map<String, String> data = {
      "method": "charge",
      "amount": "$amount"
    }; // body
    ResponseResult.processing;
    Response response;
    try {
      // request 실행. 그 결과를 response에 받기.
      response = await dio.post(url,
          data: data,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));
      // response 의 statuscode가 성공(200)일때만 body 의 result 항목 리턴.
      // 성공(200)이 아닌 경우 마지막에 null 리턴하기.
      if (response.statusCode == 200) {
        ResponseResult.success;
        return response.data["result"];
      }
    } catch (e) {
      ResponseResult.error;
      Logger().e("error on Datahandler : $e");
    }
    // 성공(200)이 아닌 경우 마지막에 null 리턴하기.
    return null;
  } // end of getForRefundPoints

  // 포인트 환전하기
  @override
  postForRefundPoints(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {'accept': 'application/json', 'Authorization': "Bearer $accessToken"};
    Map<String, String> data = {"method": "convert", "amount": "$amount"};
    ResponseResult.processing;
    try {
      Response response = await dio.post(url,
          data: data,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));
      if (response.statusCode == 200) {
        ResponseResult.success;
        return response.data["result"];
      }
    } catch (e) {
      ResponseResult.error;
      Logger().e("error on Datahandler : $e");
    }
    return null;
  } // end of getForRefundPoints

  // 내 잔여 포인트 확인하기
  @override
  Future<Response?> getMyPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');

    var headers = {'accept': 'application/json', 'Authorization': accessToken};
    try {
      Response response = await dio.get(url,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      Logger().e("error on Datahandler : $e");
    }
    return null;
  } // end of getMyPoints
}
