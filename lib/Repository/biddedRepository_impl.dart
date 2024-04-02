import 'dart:convert';

import 'package:fishauction_app/Datahandler/datahandler_impl.dart';
import 'package:fishauction_app/Model/doneAuction_model.dart';
import 'package:fishauction_app/Repository/biddedRepository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiddedRepositroyImpl implements BiddedRepositroy{
  @override
  Future<(String, List<DoneAuctionModel>)> getMyAuctionList(String type) async {
    List<DoneAuctionModel> myAucList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await DataSourceImpl().get('bidded/user/$type', headers);

    try {
      var rbody = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> result = rbody['result'];
      myAucList.addAll(result.map((data) => DoneAuctionModel.fromJson(data)));
      return ("success", myAucList);
    } catch (e) {
      Logger().e("에러: $e");
      return ("목록이 없습니다.", myAucList);
    }
  }
}
