// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fishauction_app/ViewModel_Controller/auctionimg_controller.dart';
import 'package:fishauction_app/Custom/text_middle.dart';
import 'package:fishauction_app/Custom/text_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AuctionGrid extends StatelessWidget {
  final String title;
  final String fish;
  final int price;
  final String content;
  final String insertDate;
  final bool type;
  final String? urlImg;
  const AuctionGrid({
    Key? key,
    required this.title,
    required this.fish,
    required this.price,
    required this.content,
    required this.insertDate,
    required this.type,
    required this.urlImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(title);
    // print(urlImg);
    // print("123123 : $insertDate");
    // if(title == "도미팝니당!"){
    //   print("*****\n");
    //   print(urlImg);
    // }
    double? widthSize = ResponsiveValue(
          context,
          conditionalValues: [
            Condition.equals(name: MOBILE, value: 120.0),
            Condition.equals(name: TABLET, value: 150.0),
            Condition.equals(name: '2K', value: 180.0),
            Condition.equals(name: '4K', value: 210.0),
          ],
        ).value ??
        100;
        // print("Gird 열기");
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.blueGrey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<AuctoinImgController, File?>(builder: (context, state) {
              // print("state: $state");
              if (state == null) {
                // print("loadImg 시작전 urlImg : " + urlImg!);
                _loadImg(context, urlImg!);
                
              }
              return state != null
                  ? SizedBox(
                    width: widthSize,
                    height: widthSize,
                    child: Image.file(
                        state,
                        width: widthSize,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, error, stackTrace) {
                          // print("error 발생 : $title \n error : $error");
                          return Image.asset(
                            'images/fishing_default.jpeg',
                            width: widthSize,
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                  )
                  : Image.asset(
                      'images/fishing_default.jpeg',
                      width: widthSize,
                      fit: BoxFit.fitWidth,
                    );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextMiddle(msg: title)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextSmall(msg: "$fish\t\t현재가 : $price")],
            )
          ],
        ));
  } //end of Widget

  _loadImg(BuildContext ctx, String imgname) {
    // print("_loadImg : " + imgname);
    ctx.read<AuctoinImgController>().loadImg(imgname);
  }

  //fuction
} //end of class

