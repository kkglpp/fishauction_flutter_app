import 'dart:convert';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';
import 'package:fishauction_app/Model_datahandler/datahandler_auctions_impl.dart';
import 'package:fishauction_app/Model_datahandler/datahandler_http_impl.dart';
import 'package:fishauction_app/Model_Repository/auctionsRepository.dart';
import 'package:fishauction_app/Model_model/auction_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model_datahandler/staticforDatahandler.dart';

class AuctionsRepositoryImpl implements AuctionsRepository {
  // 모든 경매리스트 가져오는 함수
  @override
  Future<List<AuctionModel>?> getWholeList() async {
    DatahandlerAuctionsImpl datasource = DatahandlerAuctionsImpl();

    // List<AuctionModel> auctionList = [];
/* HTTP 쓸때 코드
    //List<AuctionModel> auctionList = [];
    // var response = await DatahandlerHttpImpl().get('auctions', headers);
    // var rbody = json.decode(utf8.decode(response.bodyBytes));
     // 결과로 받은 것은 List<dynamic> 형태이다. 
    //그렇기때문에 이를 map 을 이용해서 내가 지정한 모델의 리스트로 바꿔야 한다. 
        List<dynamic> result = rbody['result'];
    auctionList.addAll(result.map((data) => AuctionModel.fromJson(data)));
     */

    Response? response =
        await datasource.get(); //data handler 를 통해서 서버에서 경매 목록을 받아옴.
    if (response == null) {
      return null;
    } // datahandler 에서 에러 발생해서 null 값 넘어오는 경우 처리. null 반환.

    try {
      Map<String, dynamic> rbody = response.data;
      List<AuctionModel> auctionList = rbody['result']
          .map<AuctionModel>((json) => AuctionModel.fromJson(json))
          .toList();
      return auctionList;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  } // end of getWholeList

  // Function01 : 경매1개의 정보 가저오는 함수.
  @override
  Future<AuctionModel?> getAuction(int auctionid) async {
    //Field
    var headers = {
      'accept': 'application/json',
    };
    var response =
        await DatahandlerHttpImpl().get('auctions/$auctionid', headers);
    //response 가 에러일 경우에는 null 리턴
    if (response == ResponseResult.error) {
      return null;
    }
    //JSON 으로 디코딩해서 결과 리턴 하기.
    try {
      var rbody = json.decode(utf8.decode(response.bodyBytes));
      return AuctionModel.fromJson(rbody['result']);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  } //end of getAuction

  @override
  bidAuction(int aucID, int newPrice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var response = await DatahandlerHttpImpl()
        .patch('auctions/$aucID/$newPrice', null, headers: headers);
    return response.statusCode;
  }

  // 경매 등록하는 요청
  @override
  openAuction(Map<String, String>? postdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var response = await DatahandlerHttpImpl()
        .post("auctions/", postdata, headers: headers);
    if (response != ResponseResult.error) {
      return true;
    } else {
      return false;
    }
  } //end of openAuction
} //end of AuctionListVM