import 'package:fishauction_app/Model_Repository/biddedRepository.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';
import 'package:fishauction_app/Model_model/doneAuction_model.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

import '../Model_datahandler/datahandler_bidded_impl.dart';

class BiddedRepositroyImpl implements BiddedRepositroy {
  DatahandlerBiddedImpl datasource = DatahandlerBiddedImpl();
  @override
  Future<(String, List<DoneAuctionModel>)> getMyAuctionList(
      String type) async {
    List<DoneAuctionModel> myAucList = [];
    ResponseResult status = ResponseResult.processing;

    Response? response = await datasource.getForMyAuctionList(type);
    if (response == null) {
      status = ResponseResult.Empty;
      return ("정보를 가져오는 중\n문제가 발생했습니다.", myAucList);
    } else {
      try {
        Map<String, dynamic> rbody = response.data;
        myAucList = rbody["result"]
            .map<DoneAuctionModel>((json) => DoneAuctionModel.fromJson(json))
            .toList();
        status = ResponseResult.success;
        return ("success", myAucList);
      } catch (e) {
        status = ResponseResult.error;
        Logger().e("에러: $e");
        return ("정보를 가져오는 중\n문제가 발생하였습니다.", myAucList);
      }
    } // if else 끝
  }//getMyAuctionList 끝
}
