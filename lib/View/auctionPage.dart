import 'dart:io';

import 'package:fishauction_app/Model_Repository/auctionsRepository_impl.dart';
import 'package:fishauction_app/ViewModel_Controller/auctionImg_Controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auctionPage_Controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auctionPage_SliderController.dart';
import 'package:fishauction_app/Custom/textSmall.dart';
import 'package:fishauction_app/Custom/textTitle.dart';
import 'package:fishauction_app/Model_model/auction_model.dart';
import 'package:flutter/material.dart';

import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:intl/intl.dart';

class AuctionPage extends StatelessWidget {
  final int auctionid;

  final String? pic;

  const AuctionPage({
    Key? key,
    required this.auctionid,
    required this.pic,
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
                                  clr: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
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
                                builder: (context, state) {
                              if (state == null) {
                                _loadImg(context, pic!);
                              }
                              return state != null
                                  ? Image.file(
                                      state,
                                      width: widthSize,
                                      fit: BoxFit.fitWidth,
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                                      msg: "현재 가격 : \t ${state.pricenow} 원",
                                      clr: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      ta: 2),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          BlocBuilder<AuctionPageSliderController, int>(
                              builder: (context, sstate) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        if (sstate - 5000 < 10000) {
                                          cantAlert(context, true);
                                        } else {
                                          context
                                              .read<
                                                  AuctionPageSliderController>()
                                              .sliderChange(
                                                  (sstate - 5000).toDouble());
                                        }
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        size: widthSize * 0.15,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: widthSize * 1.4,
                                      child: Slider(
                                          value: sstate.toDouble(),
                                          min: 10000,
                                          divisions: (100000 - 10000) ~/ 5000,
                                          max: 100000,
                                          onChanged: (value) {
                                            context
                                                .read<
                                                    AuctionPageSliderController>()
                                                .sliderChange(value);
                                          }),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        if (sstate + 5000 > 100000) {
                                          cantAlert(context, false);
                                        } else {
                                          context
                                              .read<
                                                  AuctionPageSliderController>()
                                              .sliderChange(
                                                  (sstate + 5000).toDouble());
                                        }
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        size: widthSize * 0.15,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                TextMiddle(
                                  msg:
                                      "입찰가격 : ${NumberFormat('#,###').format(state.pricenow)} + ${NumberFormat('#,###').format(sstate)} = ${NumberFormat('#,###').format(state.pricenow + sstate)}",
                                  clr: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: widthSize * 1.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {
                                            doBid(context, state.auctionid,
                                                state.pricenow + sstate);
                                          },
                                          child: const TextMiddle(
                                            msg: "입찰하기",
                                            clr: Colors.red,
                                          )),
                                      const Spacer(),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const TextMiddle(
                                            msg: "돌아가기",
                                            clr: Colors.blue,
                                          )),
                                      const Spacer(),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
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

  doBid(BuildContext ctx, int aucID, int newPrice) async {
    int rsStatus = await AuctionsRepositoryImpl().bidAuction(aucID, newPrice);
    if (rsStatus == 200) {
      bidAlert(ctx, true);
    } else {
      bidAlert(ctx, false);
    }
  }

  bidAlert(BuildContext ctx, bool rs) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextBig(
              msg: rs ? "입찰에 성공하였습니다." : "입찰에 실패하였습니다. 포인트를 확인해 주세요.",
              clr: Colors.white,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(ctx).pop();
                },
                child: const TextMiddle(
                  msg: "확 인",
                ),
              )
            ],
          );
        });
  }

  cantAlert(BuildContext ctx, bool tf) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor: Colors.blueGrey,
        content: tf
            ? TextBig(
                msg: "최소 입찰금액은 기존 입찰금 +10,000원 입니다.",
                clr: Theme.of(ctx).colorScheme.onBackground,
              )
            : TextBig(
                msg: "입찰금액은 기존 입찰금 +100,000원 을 넘을 수 없습니다.",
                clr: Theme.of(ctx).colorScheme.onBackground,
              )));
  }

  _loadImg(BuildContext ctx, String imgname) {
    ctx.read<AuctoinImgController>().loadImg(imgname);
  }
}//end of auctionPage
