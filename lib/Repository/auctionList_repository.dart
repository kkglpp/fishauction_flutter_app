import 'dart:convert';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:fishauction_app/DataSource/datasource.dart';
import 'package:fishauction_app/DataSource/datasource_impl.dart';
import 'package:fishauction_app/Model/auction_model.dart';


class AuctionListRepository  {
  List<AuctionModel> auctionList= [];

  // 모든 경매리스트 가져오는 함수
  getWholeList() async {
    // auctionList=[];

    auctionList=[];


    var headers = {
      'accept': 'application/json',
    };
    
    var response = await DataSourceImpl().get('auctions', headers);
    var rbody = json.decode(utf8.decode(response.bodyBytes));    
    // print("전체 리스트 새로 가져오기전");
    // print(auctionList);
    // print('rbody');
    // print(rbody);
    // print("*******---**********");
    // print(rbody['result']);
    // print("*******---**********");

    /* 결과로 받은 것은 List<dynamic> 형태이다. 
    그렇기때문에 이를 map 을 이용해서 내가 지정한 모델의 리스트로 바꿔야 한다. */
    List<dynamic> result = rbody['result'];


    for(int i =0; i<result.length; i++){
      auctionList.add(AuctionModel(
        auctionid: result[i]['auctionid'],
        seller_id: result[i]['seller_id'],
        title: result[i]['title'],
        content: result[i]['content'],
        pic: result[i]['pic'],
        // pic: await FirebaseStorage.instance.ref(result[i]['pic']).getDownloadURL(),
        fish: result[i]['fish'],
        view: result[i]['view'],
        pricestart: result[i]['pricestart'],
        pricenow: result[i]['pricenow'],
        insertdate: result[i]['insertdate'],
        deletedate: result[i]['deletedate'],
        issuccessed: result[i]['issuccessed'],
      ));
    };
    print('전체리스트 가져온 후 auctionList');
    print(auctionList[0].auctionid);

  }
} //end of AuctionListVM