import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_datahandler/datahandler_bidded.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'staticforDatahandler.dart';

class DatahandlerBiddedImpl implements DataHandlerBidded {
  final dio = Dio();
  String url = "${defaultURL}bidded/";
  @override
  Future<Response?> getForMyAuctionList(String type) async {
    String newurl = url +'/user/' +type;
    print(newurl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    try {
      Response response = await dio.get(
        newurl,
        options: Options(
          headers: headers,
        ),
      );
      return response;
    } catch (e) {
      Logger().e("dataHandler Error : $e");
      return null;
    }
  }
}
