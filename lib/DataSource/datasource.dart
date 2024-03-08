import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class DataSource {
//env 파일에서 가져온 URL 주소.

  get(
    String addurl,
    Map<String, String>? headers,
  );
  post(
    String addurl,
    dynamic data, {
    Map<String, String>? headers,
  });
  put(
    String addurl,
    dynamic data, {
    Map<String, String>? headers,
  });
  patch(
    String addurl,
    dynamic data, {
    Map<String, String>? headers,
  });
  delete(
    String addurl,
    dynamic data, {
    Map<String, String>? headers,
  });
} //end of DataSource

enum ResponseResult { error, success }

final String? defaultURL = dotenv.env['baseurl'];
var validStatusCodes = List.generate(100, (i) => 200 + i);

//RestAPI에 부합되는 get post put patch Delete 기본 함수 만들기
class DataSourceImpl implements DataSource {
  @override
  get(String addurl, Map<String, String>? headers) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      if (!validStatusCodes.contains(response.statusCode))
        return ResponseResult.error;

      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
      print("get 실행 문제 있음");
      print(e);
    }
  } //end of get

  //Post 함수
  @override
  post(String addurl, data, {Map<String, String>? headers}) async {
    print("Post 시작 url: "+defaultURL.toString());
    var url = Uri.parse('$defaultURL$addurl');
    print (url);
    try {
      print("try 들어옴 1줄");
      var response = await http.post(
        url,
        headers: headers,

        body: json.encode(data),
      );
      print(response.body);
      print("try 들어옴 2줄");
      print(response.statusCode);
      if (!validStatusCodes.contains(response.statusCode))
        return ResponseResult.error;
      print("post 실행문제 없음. ");
      // var bodyData = json.decode(utf8.decode(response.bodyBytes));
      // print("**************************************************************");
      // print("______ body 데이터 ______");
      // print(bodyData);
      // print("______ head 데이터 ______");
      // print(response.headers);
      // print("**************************************************************");

      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
      print("post 실행 문제 있음");
      print(e);
    }
  } //end of post

  //Post File 함수
  postFile(String addurl, String filePath, {Map<String, String>? headers}) async {
    print(defaultURL);
    var url = Uri.parse('$defaultURL$addurl');
    var request = http.MultipartRequest('POST',url);
    request.headers.addAll(headers!);
  // 파일을 업로드할 경로 설정
  var file = await http.MultipartFile.fromPath('file', filePath);

  // MultipartFile을 요청에 추가
  request.files.add(file);


    try {
      print("try 들어옴 1줄");
      var response = await request.send();
      print("response.stream");
      print(response.stream);
      var responseData = await response.stream.toBytes();
      print("file 넘기고 받은 responseData : ");
      print(responseData);
      print("file 넘기고 받은 responseData to String : ");
      print(String.fromCharCodes(responseData));





      if (!validStatusCodes.contains(response.statusCode))
        return ResponseResult.error;
      print("post 실행문제 없음. ");


      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
      print("post 실행 문제 있음");
      print(e);
    }
  } //end of post

  //PUT
  @override
  put(String addurl, data, {Map<String, String>? headers}) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.get(
        url,
        headers: headers,
      );
      if (!validStatusCodes.contains(response.statusCode))
        return ResponseResult.error;
      print("PUT 실행문제 없음. ");

      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
      print("PUT 실행 문제 있음");
      print(e);
    }
  } //end of put

/* **************************************************************** */

  //patch
  @override
  patch(String addurl, data, {Map<String, String>? headers}) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.patch(
        url,
        headers: headers,
      );
      if (!validStatusCodes.contains(response.statusCode))
        return ResponseResult.error;
      print("patch 실행문제 없음. ");

      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
      print("patch 실행 문제 있음");
      print(e);
    }
  } //end of put

  //delete
  @override
  delete(String addurl, data, {Map<String, String>? headers}) async {
    var url = Uri.parse('$defaultURL$addurl');
    try {
      var response = await http.get(
        url,
        headers: headers,
      );
      if (!validStatusCodes.contains(response.statusCode))
        return ResponseResult.error;
      print("delete 실행문제 없음. ");

      return response;
    } catch (e) {
      Logger().e("$addurl\n$e");
      print("delete 실행 문제 있음");
      print(e);
    }
  } //end of put
} // end of impl
