import 'dart:convert';

import 'package:fishauction_app/Model_datahandler/datahandler_http_impl.dart';
import 'package:fishauction_app/Model_Repository/balanceRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceRepositoryImpl implements BalanceRepository{
  @override
  getMyPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.get('accessToken');

    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    }; //end of headers

    var response = await DatahandlerHttpImpl().get('balance/', headers);
    print(response);
    var rbody = json.decode(utf8.decode(response.bodyBytes));
    int rsPoints = int.parse(rbody['result']);

    return rsPoints;
  } //end of getMyPoints function

  @override
  chargeMyPoints(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.get('accessToken');

    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    }; //end of headers

    Map<String, String>? data = {
      'method': 'charge',
      'amount': points.toString()
    };

    try {
      var response =
          await DatahandlerHttpImpl().post("balance/", data, headers: headers);

      // print(response);
    } catch (e) {
      print("에러 메시지 $e");
    }
  }

  @override
  refundMyPoints(int points) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.get('accessToken');

    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    }; //end of headers

    Map<String, String>? data = {
      'method': 'convert',
      'amount': points.toString()
    };

    try {
      var response =
          await DatahandlerHttpImpl().post("balance/", data, headers: headers);

      print(response);
    } catch (e) {
      print("에러 메시지 $e");
    }
  }
}//end of class
