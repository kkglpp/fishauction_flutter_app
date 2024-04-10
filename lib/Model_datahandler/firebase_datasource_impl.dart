import 'dart:io';
import 'dart:typed_data';

import 'package:fishauction_app/Model_datahandler/firebase_datasource.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class FirebaseDataSourceImpl implements Firebase_DataSource {
  @override
  uploadPic(String? filepath, String pic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      // Firebase Storage에 이미지 업로드
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          // .child('images')    // 폴더 추가하고 거기에 넣을 때 쓰는 코드
          .child(pic);
      await ref.putFile(File(filepath!));
    } catch (e) {
      Logger().e(e);
      return false;
    }
    return true;
  } // end of uploadPic

/*             */
  downloadPic(String? filepath) async {
    // Firebase Storage에서 이미지 다운로드
    String downloadURL = "asd.jpg"; //==> data base 최초 생성시, 만들어둔 기본 image.
    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref(filepath);
      downloadURL = await ref.getDownloadURL();
    } catch (e) {
      try{
        // 파일명 잘못 들어간 내용들 에러 처리 하기 위함.
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('$filepath.jpg');
        downloadURL = await ref.getDownloadURL();
      } catch(e) {
        // 다른 예외 상황 처리
        print("-----------------------***----------------");
        print(e);
        Logger().e(e);
        return null;
      } // try catch안의 if-else 종료
    } // try - catch(e) 종료
    http.Response response = await http.get(Uri.parse(downloadURL));
    Uint8List resultPic = response.bodyBytes;
    Directory tempDir = await getTemporaryDirectory();
    // 임시 파일 경로 생성
    String tempPath = tempDir.path + filepath!;
    File tmpFile = File(tempPath);
    await tmpFile.writeAsBytes(resultPic);

    return tmpFile;
  } // end of downloadPic
}
