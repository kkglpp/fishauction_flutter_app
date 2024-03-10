import 'dart:convert';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:fishauction_app/DataSource/datasource.dart';
import 'package:fishauction_app/DataSource/datasource_impl.dart';
import 'package:fishauction_app/Model/auction_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuctionRepository {
  List<AuctionModel> auctionList = [];

  // 모든 경매리스트 가져오는 함수
  getWholeList() async {
    auctionList = [];

    var headers = {
      'accept': 'application/json',
    };

    var response = await DataSourceImpl().get('auctions', headers);
    var rbody = json.decode(utf8.decode(response.bodyBytes));

    /* 결과로 받은 것은 List<dynamic> 형태이다. 
    그렇기때문에 이를 map 을 이용해서 내가 지정한 모델의 리스트로 바꿔야 한다. */
    List<dynamic> result = rbody['result'];
    auctionList.addAll(result.map((data) => AuctionModel.fromJson(data)));
  } // end of getWholeList

  // late AuctionModel? auction;

  // Function01 : 경매1개의 정보 가저오는 함수.
  Future<AuctionModel?> getAuction(int auctionid) async {
    //Field
    var headers = {
      'accept': 'application/json',
    };
    var response = await DataSourceImpl().get('auctions/$auctionid', headers);
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
    bool uploadeResult = false;
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
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(filepath);

      downloadURL = await ref.getDownloadURL();
    } catch (e) {
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
} //end of AuctionListVM