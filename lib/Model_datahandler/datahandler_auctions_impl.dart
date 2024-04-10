import 'package:fishauction_app/Model_datahandler/datahandler_auctions.dart';
import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';

class DatahandlerAuctionsImpl implements DatahandlerAuctions {
  final dio = Dio();
  String url = "${defaultURL}auctions/";

  @override
  delete(String addurl, data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

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
  post(String addurl, data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  put(String addurl, data, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }
}
