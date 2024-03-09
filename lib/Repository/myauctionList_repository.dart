import 'dart:convert';

import 'package:fishauction_app/DataSource/datasource.dart';
import 'package:fishauction_app/Model/doneAuction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAuctionListRepositroy {
  List<DoneAuctionModel> myAucList = [];

  Future<String> getMyAuctionList(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    myAucList = [];
    var accessToken = prefs.get('accessToken');

    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await DataSourceImpl().get('bidded/user/$type', headers);
    if (response.statusCode == 200) {
      try {
        var rbody = json.decode(utf8.decode(response.bodyBytes));

        List<dynamic> result = rbody['result'];

        for (int i = 0; i < result.length; i++) {
          myAucList.add(DoneAuctionModel(
            biddedid: result[i]["biddedid"],
            auctionid: result[i]["auctionid"],
            buyerid: result[i]["buyerid"],
            biddedprice: result[i]["biddedprice"].toInt(),
            biddeddate: result[i]["biddeddate"],
            address: result[i]["address"],
            deliverydate: result[i]["deliverydate"],
            paymentdate: result[i]["paymentdate"],
          ));
        }

        return "success";
      } catch (e) {
        return "목록이 없습니다.";
      }

      /* 결과로 받은 것은 List<dynamic> 형태이다. 
    그렇기때문에 이를 map 을 이용해서 내가 지정한 모델의 리스트로 바꿔야 한다. */
    } else {
      return "목록을 가져올 수 없습니다.\n 인터넷 연결 상태를 확인하세요.";
    }
    ; //if 문 끝
  }
}
