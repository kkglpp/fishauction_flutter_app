import 'package:fishauction_app/Model_datahandler/datahandler_auctions.dart';
import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatahandlerAuctionsImpl implements DatahandlerAuctions {
  final dio = Dio();
  String url = "${defaultURL}auctions/";



  @override
  Future<Response?> get() async {
    Map<String, dynamic> additionalHeader = {
      "accept": "application/json",
    };
    try {
      Response response = await dio.get(
        url,
        options:
            // options
            Options(headers: additionalHeader),
      );
      return response;
      // return null;
    } catch (e) {
      print("로그인 에러 발생 in dataHandler");
      print(e);
      return null;
    }

    // throw UnimplementedError();
  }

  @override
  patch(String addurl, data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseResult> postForOpenAuction(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {
      'accept': 'application/json',
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      Response response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          contentType: Headers.jsonContentType,
        )
      );
      if(response.data["message"] == "Auction created successfully"){
        return ResponseResult.success;
      }
      return ResponseResult.error;
    }catch (e){
      Logger().e("경매 등록중 에러 : $e");
      return ResponseResult.error;
    }
  }

  @override
  put(String addurl, data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

    @override
  delete(String addurl, data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }
}
