import 'package:fishauction_app/Model_Repository/bidded_repository.dart';
import 'package:fishauction_app/Model_model/done_auction_model.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

import '../Model_datahandler/datahandler_bidded_impl.dart';

class BiddedRepositroyImpl implements BiddedRepositroy {
  DatahandlerBiddedImpl datasource = DatahandlerBiddedImpl();
  @override
  Future<(String, List<DoneAuctionModel>)> getMyAuctionList(
      String type) async {
    List<DoneAuctionModel> myAucList = [];

    Response? response = await datasource.getForMyAuctionList(type);
    if (response == null) {
      return ("정보를 가져오는 중\n문제가 발생했습니다.", myAucList);
    } else {
      try {
        Map<String, dynamic> rbody = response.data;
        myAucList = rbody["result"]
            .map<DoneAuctionModel>((json) => DoneAuctionModel.fromJson(json))
            .toList();
        return ("success", myAucList);
      } catch (e) {
        Logger().e("에러: $e");
        return ("정보를 가져오는 중\n문제가 발생하였습니다.", myAucList);
      }
    } // if else 끝
  }//getMyAuctionList 끝
}
