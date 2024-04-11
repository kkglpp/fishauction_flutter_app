import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'datahandler_balance.dart';

class DatahandlerBalanceImpl implements DatahandlerBalance {
  Dio dio = Dio();
  String url = "${defaultURL}/balance/";

  //포인트 충전하기
  @override
  Future<String?> postForChargePoints(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {'accept': 'application/json', 'Authorization': accessToken};
    Map<String, String> data = {"method": "charge", "amount": "$amount"};
    ResponseResult rs = ResponseResult.processing;
    Response response;
    try {
      response = await dio.post(url,
          data: data,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));
      if (response.statusCode == 200) {
        rs = ResponseResult.success;
        return response.data["result"];
      }
    } catch (e) {
      rs = ResponseResult.error;
      Logger().e("error on Datahandler : $e");
    }
    return null;
  } // end of getForRefundPoints

  // 포인트 환전하기
  @override
  postForRefundPoints(int amount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {'accept': 'application/json', 'Authorization': accessToken};
    Map<String, String> data = {"method": "convert", "amount": "$amount"};
    ResponseResult rs = ResponseResult.processing;
    try {
      Response response = await dio.post(url,
          data: data,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));
      if (response.statusCode == 200) {
        rs = ResponseResult.success;
        return response.data["result"];
      }
    } catch (e) {
      rs = ResponseResult.error;
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
      return null;
    }
  } // end of getMyPoints
}
