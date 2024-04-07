//RestAPI에 부합되는 get post put patch Delete 기본 함수 만들기
import 'dart:convert';
import 'package:fishauction_app/Model_datahandler/datahandler.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class DatahandlerImpl implements Datahandler {
  //Get 으로 request 보내고 response 받기.

  @override
  get(String addurl, Map<String, String>? headers) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.get(url, headers: headers);
      if (!validStatusCodes.contains(response.statusCode)) {
        return ResponseResult.error;
      }
      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
      return ResponseResult.error;
    }
  } //end of get

  //Post 함수
  @override
  post(String addurl, data, {Map<String, String>? headers}) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response =
          await http.post(url, headers: headers, body: json.encode(data));
      if (!validStatusCodes.contains(response.statusCode)) {
        return ResponseResult.error;
      }

      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
    }
  } //end of post

  //PUT
  @override
  put(String addurl, data, {Map<String, String>? headers}) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.get(url, headers: headers);
      if (!validStatusCodes.contains(response.statusCode)) {
        return ResponseResult.error;
      }
      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
    }
  } //end of put

/* **************************************************************** */
  //patch
  @override
  patch(String addurl, data, {Map<String, String>? headers}) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.patch(url, headers: headers);
      if (!validStatusCodes.contains(response.statusCode)) {
        return ResponseResult.error;
      }
      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
    }
  } //end of put

  //delete
  @override
  delete(String addurl, data, {Map<String, String>? headers}) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.get(url, headers: headers);
      if (!validStatusCodes.contains(response.statusCode)) {
        return ResponseResult.error;
      }
      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
    }
  } //end of put
} // end of impl
