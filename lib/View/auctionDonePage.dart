import 'dart:io';

import 'package:fishauction_app/Controller/auctionImg_Controller.dart';
import 'package:fishauction_app/Controller/auctionPage_Controller.dart';
import 'package:fishauction_app/Controller/auctionPage_SliderController.dart';
import 'package:fishauction_app/Custom/textSmall.dart';
import 'package:fishauction_app/Custom/textTitle.dart';
import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/Repository/auctions_repository.dart';
import 'package:flutter/material.dart';

import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';

class AuctionDonePage extends StatelessWidget {
  int auctionid;

  AuctionDonePage({
    Key? key,
    required this.auctionid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? widthSize = ResponsiveValue(
          context,
          conditionalValues: [
            Condition.equals(name: MOBILE, value: 200.0),
            Condition.equals(name: TABLET, value: 220.0),
            Condition.equals(name: '2K', value: 250.0),
            Condition.equals(name: '4K', value: 300.0),
          ],
        ).value ??
        0;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuctionPageController, AuctionModel?>(
          builder: (context, state) {
        if (state == null) {
          context.read<AuctionPageController>().getAuction(auctionid);
        }
        return state == null
            ? const CircularProgressIndicator(
                color: Colors.red,
              )
            : Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*  화면 구성 1
                          경매 타이틀 -  TextTitle
                          판매자 아이디 + 판매 상황 - Row
                          경매 등록 일시 - Row - textsmall
                          구분선 - padding - sizedbox - Divder
                           */
                          TextTitle(
                            msg: state.title,
                            clr: Theme.of(context).colorScheme.onBackground,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextMiddle(
                                msg: state.seller_id,
                                clr: Theme.of(context).colorScheme.onBackground,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextSmall(
                                msg: state.issuccessed ? "판매 완료" : "판매 중",
                                clr: Theme.of(context).colorScheme.onBackground,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextSmall(
                                  msg: state.insertdate,
                                  clr: Theme.of(context).colorScheme.onBackground),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: SizedBox(
                              width: widthSize * 1.8,
                              child: const Divider(),
                            ),
                          ),
                          /*  화면 구성 2 
                              경매 품목 사진 - image
                              판매자 한마디 - 
                              최초 경매 시작 가격 - 
                              현재 입찰 가격 - 
                              입찰금액 조절 - 
                              입찰 버튼, 취소 버튼 -
                           */
                          SizedBox(
                            height: widthSize,
                            width: widthSize * 1.2,
                            child: BlocBuilder<AuctoinImgController, File?>(
                                builder: (context, sstate) {
                              if (sstate == null) {
                                _loadImg(context, state.pic);
                              }
                              return sstate != null
                                  ? Image.file(
                                      sstate,
                                      width: widthSize,
                                      fit: BoxFit.fitWidth,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          'images/fishing_default.jpeg',
                                          width: widthSize,
                                          fit: BoxFit.fitWidth,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'images/fishing_default.jpeg',
                                      width: widthSize,
                                      fit: BoxFit.fitWidth,
                                    );
                            }),
                          ),
                          const Spacer(),
                          Container(
                            width: widthSize * 1.9,
                            height: widthSize * 0.6,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.blueGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextBig(
                                msg: state.content,
                                clr: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: widthSize * 0.9,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.blueGrey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextMiddle(
                                      msg: "시작가 : \t${state.pricestart} 원",
                                      clr: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      ta: 2),
                                ),
                              ),
                              SizedBox(
                                width: widthSize * 0.1,
                              ),
                              Container(
                                width: widthSize * 0.9,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.blueGrey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextMiddle(
                                      msg: "판매 가격 : \t ${state.pricenow} 원",
                                      clr: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      ta: 2),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(180),
                                  minimumSize: Size(widthSize*1.9, 50)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: TextMiddle(msg: "확인",clr: Theme.of(context).colorScheme.inverseSurface,)),
                          const Spacer(),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  } //end of widgetBuild

  //function

  _loadImg(BuildContext ctx, String imgname) {
    ctx.read<AuctoinImgController>().loadImg(imgname);
  }
}//end of auctionPage
