import 'dart:io';

import 'package:fishauction_app/Model_Repository/auctionsRepository_impl.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Custom/textBig.dart';
import '../Custom/textMiddle.dart';
import '../Model_datahandler/firebase_datasource_impl.dart';

class OpenAuctionImgController extends Cubit<XFile?> {
  OpenAuctionImgController(super.initialState);
  final ImagePicker imgPicker = ImagePicker();

  selectImage() async {
    try {
      XFile? tmpFile = await imgPicker.pickImage(source: ImageSource.gallery);
      // File imgFile = File(tmpFile!.path);
      emit(tmpFile);
    } catch (e) {
      emit(null);
    }
  } //selectImage

  //경매 열기 (Firestorage에 이미지저장 -> 경매 열기 요청)
  openAuction(Map<String, String> postdata, String filepath,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pic =
        '${prefs.get('uid')}${DateFormat('yy-MM-dd_HH-mm-ss').format(DateTime.now())}.jpg';
    ResponseResult result = ResponseResult.processing;
    try {
      await FirebaseDataSourceImpl().uploadPic(filepath, pic);
    } catch (e) {
      Logger().e("img업로드 문제as : $e");
      return;
    }
// 이미지 Firebase 업로드하기 끝
// 서버에 경매 정보 업로드하기
    try {
      result = await AuctionsRepositoryImpl().openAuction(postdata);
    } catch (e) {
      result = ResponseResult.error;
    }
//서버에 경매 정보 업로드하기 끝
    if (result == ResponseResult.success) {
      Logger().d("성공: 성공");
      successAlert(context);
    } else {
      Logger().e("에러: 서버에 업로드 안됨");
      failAlert(context);
    }
    return result;
  }

  // showAlert(ResponseResult result, BuildContext context){
  //       if (result == ResponseResult.success) {
  //         Logger().d ("성공: 성공");
  //         successAlert(context);
  //       } else {
  //         Logger().e("에러: 서버에 업로드 안됨");
  //         failAlert(context);
  //       }
  // }

  // 경매 등록 완료 메시지
  successAlert(BuildContext ctx) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const TextBig(
              msg: "경매 등록 성공",
              clr: Colors.blue,
            ),
            content: TextMiddle(
                ta: 1,
                clr: Theme.of(ctx).colorScheme.onBackground,
                msg: "경매 등록이 완료 되었습니다."),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("확인")),
              ),
            ],
          );
        });
  } //success alert 종료

  // 경매 등록 완료 메시지
  failAlert(BuildContext ctx) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const TextBig(
              msg: "경매 등록 실패",
              clr: Colors.blue,
            ),
            content: TextMiddle(
                ta: 1,
                clr: Theme.of(ctx).colorScheme.onBackground,
                msg: "경매가 등록되지 않았습니다."),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("확인")),
              ),
            ],
          );
        });
  } //success alert 종료
}//end of class
