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

