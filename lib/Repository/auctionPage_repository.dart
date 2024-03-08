import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fishauction_app/DataSource/datasource.dart';
import 'package:fishauction_app/Model/auction_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class AuctionPageRepository {
  // 경매 페이지의 vm. 3가지 기능이 필요함
  // 처음 경매 정보 가져오는 함수
  // 입찰을 위한 함수
  // 새로고침 함수

  late AuctionModel? auction;

  // Function01 : 경매1개의 정보 가저오는 함수.
  getAuction(int auctionid) async {
    //Field
    auction = null;
    var headers = {
      'accept': 'application/json',
    };
    var response = await DataSourceImpl().get('auctions/$auctionid', headers);
    var rbody = json.decode(utf8.decode(response.bodyBytes));
    auction = AuctionModel(
        auctionid: rbody['result']['auctionid'],
        seller_id: rbody['result']['seller_id'],
        title: rbody['result']['title'],
        content: rbody['result']['content'],
        pic: rbody['result']['pic'],
        fish: rbody['result']['fish'],
        view: rbody['result']['view'],
        pricestart: rbody['result']['pricestart'],
        pricenow: rbody['result']['pricenow'],
        insertdate: rbody['result']['insertdate'],
        deletedate: rbody['result']['deletedate'],
        issuccessed: rbody['result']['issuccessed']);
  } //end of getAuction

  bidAuction(int aucID, int newPrice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var accessToken = prefs.get('accessToken');
    var headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await DataSourceImpl()
        .patch('auctions/$aucID/$newPrice', null, headers: headers);

    return response.statusCode;
  }

  //사진을 FireBase에 올리는 요청
  uploadPic(String? filepath, String pic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

        // String pic = prefs.get('uid').toString() +
        // DateFormat('yy-MM-dd_HH-mm-ss').format(DateTime.now()).toString();
        bool uploadeResult = false ;
    // bool uploadeResult = await AuctionPageRepository().uploadPic(filepath,pic);
    try {
      // Firebase Storage에 이미지 업로드
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          // .child('images')    // 폴더 추가하고 거기에 넣을 때 쓰는 코드
          .child('$pic.jpg');
      await ref.putFile(File(filepath!));
      uploadeResult = true;
    } catch (e) {
      uploadeResult = false;
    }
    return uploadeResult;

  } // uploadPic

  //이미지 가져오는 함수
  downloadPic(String? filepath) async {
    // Firebase Storage에서 이미지 다운로드
    String downloadURL = "asd.jpg"; 
    try{ 
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(filepath);
    
      downloadURL = await ref.getDownloadURL();
    }
    catch (e){
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('${filepath!}.jpg');
      downloadURL = await ref.getDownloadURL();

    }
    http.Response response = await http.get(Uri.parse(downloadURL));
    Uint8List resultPic = response.bodyBytes;
    Directory tempDir = await getTemporaryDirectory();
    // 임시 파일 경로 생성
    String tempPath = tempDir.path + filepath!;
    File tmpFile = File(tempPath);
    await tmpFile.writeAsBytes(resultPic);

    return tmpFile;
  }

  // 경매 등록하는 요청
  openAuction(Map<String, String>? postdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.get('accessToken');
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
    var response =
        await DataSourceImpl().post("auctions/", postdata, headers: headers);
    if (response != ResponseResult.error) {
      return true;
    } else {
      return false;
    }
  } //end of openAuction

  //경매 등록하기전에, 사진으로 어종 예측하는 요청
  predictRequest(String filePath) async {
    //       SharedPreferences prefs = await SharedPreferences.getInstance();

    //   var accessToken = prefs.get('accessToken');
    //   var headers = {
    //     'accept': 'application/json',
    //     'Content-Type': 'multipart/form-data',
    //   };

    //   var response =
    //       await DataSourceImpl().postFile("ai/", filePath, headers: headers);
    // print("Repository에서  response : \n $response");
  }
}
