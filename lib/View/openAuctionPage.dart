import 'dart:io';

import 'package:fishauction_app/ViewModel_Controller/openAuctionImg_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/openAuctionPrice_controller.dart';
import 'package:fishauction_app/Custom/insertTextBox.dart';
import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:fishauction_app/Custom/textTitle.dart';
import 'package:fishauction_app/Datahandler/firebase_datasource_impl.dart';
import 'package:fishauction_app/Repository/auctions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenAuctionPage extends StatelessWidget {
  OpenAuctionPage({super.key});
  late XFile? imgFile;
  late int startPrice;
  TextEditingController titleTec = TextEditingController();
  TextEditingController contentTec = TextEditingController();
  TextEditingController fishTec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double? widthSize = ResponsiveValue(
          context,
          conditionalValues: [
            Condition.equals(name: MOBILE, value: 400.0),
            Condition.equals(name: TABLET, value: 450.0),
            Condition.equals(name: '2K', value: 550.0),
            Condition.equals(name: '4K', value: 600.0),
          ],
        ).value ??
        0;
return Scaffold(
  appBar: AppBar(),
  body: Center(
    child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView( // SingleChildScrollView 추가
            child: Column(
              children: [
                TextTitle(
                  msg: "Open your Auction",
                  clr: Theme.of(context).colorScheme.onBackground,
                ),
                SizedBox(
                  height: 30,
                  width: widthSize,
                  child: const Divider(),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<OpenAuctionImgController, XFile?>(
                    builder: (context, state) {
                  if (state == null) {
                    selectImage(context);
                  } else {
                    imgFile = state;
                  }
                  return state == null
                      ? Image.asset(
                          "images/fishing_default.jpeg",
                          width: widthSize * 0.8,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.file(
                          File(state.path),
                          width: widthSize * 0.8,
                          fit: BoxFit.fitWidth,
                        );
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InsertTextBox(
                    tec: titleTec,
                    content: "경매 제목",
                    paddingEdge: 5,
                    widthSize: widthSize,
                  ),
                ),
                InsertTextBox(
                    tec: fishTec,
                    content: "어종",
                    paddingEdge: 5,
                    widthSize: widthSize),
                InsertTextBox(
                    tec: contentTec,
                    content: "판매자 한마디",
                    paddingEdge: 5,
                    maxLine: 3,
                    widthSize: widthSize),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    child: Container(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: widthSize * 0.3,
                              child: TextBig(
                                msg: "경매 시작가 : ",
                                clr: Theme.of(context).colorScheme.onBackground,
                                ta: 0,
                              )),
                          BlocBuilder<OpenAuctionPriceController, int>(
                              builder: (context, state) {
                            startPrice = state;
                            return SizedBox(
                              width: widthSize * 0.3,
                              child: TextBig(
                                msg: "${NumberFormat('#,###').format(state)} 원",
                                clr: Theme.of(context).colorScheme.onBackground,
                                ta: 0,
                              ),
                            );
                          }),
                          SizedBox(
                            width: widthSize * 0.05,
                          ),
                          SizedBox(
                            width: widthSize * 0.15,
                            child: IconButton(
                              onPressed: () {
                                startPrice -= 5000;
                                if (startPrice < 10000) {
                                  startPrice += 5000;
                                  errorAlert(context);
                                } else {
                                  context
                                      .read<OpenAuctionPriceController>()
                                      .minusStartPrice(context);
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                size: widthSize * 0.1,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: widthSize * 0.05,
                          ),
                          SizedBox(
                            width: widthSize * 0.15,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<OpenAuctionPriceController>()
                                    .plusStartPrice();
                              },
                              icon: Icon(
                                Icons.add,
                                size: widthSize * 0.1,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: widthSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(widthSize * 0.4, 40),
                  backgroundColor: Colors.brown[400]
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: TextBig(
                  msg: "취 소",
                  clr: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(widthSize * 0.4, 40),
                  backgroundColor: Colors.blue[400]
                ),
                onPressed: () {
                  openRequest(context, startPrice, titleTec.text, fishTec.text, contentTec.text, imgFile!.path);
                },
                child: TextBig(
                  msg: "확 인",
                  clr: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  ),
);
  } // end of widget

  // 갤러리 들어가는 함수
  selectImage(BuildContext context) async {
    await context.read<OpenAuctionImgController>().selectImage();
  }

  //경매 열기 (Firestorage에 이미지저장 -> 경매 열기 요청)
  //경매 열기 확인버튼 누르면 작동
  openRequest(BuildContext context, int startprice, String title, String fish,
      String content, String filepath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pic = '${prefs.get('uid')}${DateFormat('yy-MM-dd_HH-mm-ss').format(DateTime.now())}.jpg';

    bool uploadeResult = await FirebaseDataSourceImpl().uploadPic(filepath, pic);
    try{
    if (uploadeResult) {
      Map<String, String>? postdata = {
        'pricestart': startprice.toString(),
        'title': title,
        'content': content,
        'fish': fish,
        'pic': pic
      };

      bool result = await AuctionsRepository().openAuction(postdata);

      if (result) {
        successAlert(context);
      } else {
        failAlert(context);
      }
    } else {
      failAlert(context);
    }
    }
    catch (e){
        Logger().e("에러: $e");
    }
  }

  // 경매 시작가격 오류 메시지
  errorAlert(BuildContext ctx) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const TextBig(
              msg: "시작가격을 더이상 낮출 수 없습니다.",
              clr: Colors.blue,
            ),
            content: TextMiddle(
                ta: 0,
                clr: Theme.of(ctx).colorScheme.onBackground,
                msg: "경매 시작 가격은 \n 최저 10,000원에서 시작하여야 합니다."),
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
  } //error alert 종료

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