import 'package:flutter_dotenv/flutter_dotenv.dart';

enum ResponseResult { error, success, processing, empty }
final String? defaultURL = dotenv.env['baseurl'];
var validStatusCodes = List.generate(100, (i) => 200 + i);  // request 성공할떄의 statuscode 범위
