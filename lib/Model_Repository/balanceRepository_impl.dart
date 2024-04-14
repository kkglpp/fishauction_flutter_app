import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_datahandler/datahandler_balance_impl.dart';
import 'package:fishauction_app/Model_datahandler/datahandler_http_impl.dart';
import 'package:fishauction_app/Model_Repository/balanceRepository.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  DatahandlerBalanceImpl datasource = DatahandlerBalanceImpl();

  @override
  getMyPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.get('accessToken');

    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    }; //end of headers

    var response = await DatahandlerHttpImpl().get('balance/', headers);
    var rbody = json.decode(utf8.decode(response.bodyBytes));
    int rsPoints = int.parse(rbody['result']);

    return rsPoints;
  } //end of getMyPoints function

  @override
  chargeMyPoints(int amount) async {
    try {
      String? rs = await datasource.postForChargePoints(amount);
      print(rs);
      if (rs! == 'Success') {
        return ResponseResult.success;
      }
    } catch (e) {
      Logger().e("error in Repositroy :\n$e");
    }
    return ResponseResult.error;
  }

  @override
  refundMyPoints(int amount) async {
    try {
      String? rs = await datasource.postForRefundPoints(amount);
      if (rs! == 'Success') {
        return ResponseResult.success;
      }
    } catch (e) {
      Logger().e("error in Repositroy : $e");
    }
    return ResponseResult.error;
  }
}//end of class
