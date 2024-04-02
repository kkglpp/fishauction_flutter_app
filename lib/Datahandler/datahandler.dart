import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ResponseResult { error, success }
final String? defaultURL = dotenv.env['baseurl'];
var validStatusCodes = List.generate(100, (i) => 200 + i);  // request 성공할떄의 statuscode 범위

abstract class DataSource {
  
  get(String addurl, Map<String, String>? headers);
  post(String addurl, dynamic data, {Map<String, String>? headers});
  put(String addurl, dynamic data, {Map<String, String>? headers});
  patch(String addurl, dynamic data, {Map<String, String>? headers});
  delete(String addurl, dynamic data, {Map<String, String>? headers});
} //end of DataSource


