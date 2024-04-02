import 'package:fishauction_app/ViewModel_Controller/pointChanging_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/pointCharger_controller.dart';
import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:fishauction_app/Custom/textTitle.dart';
import 'package:fishauction_app/Repository/balance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../ViewModel_Controller/myInfoPage_controller.dart';

class PointRefundPage extends StatelessWidget {
  const PointRefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    double? widthSize = ResponsiveValue(
          context,
          conditionalValues: [
            Condition.equals(name: MOBILE, value: 350.0),
            Condition.equals(name: TABLET, value: 400.0),
            Condition.equals(name: '2K', value: 450.0),
            Condition.equals(name: '4K', value: 500.0),
          ],
        ).value ??
        0;
    bool loadcheck = false;
    int beforePoint = 0;
    int addPoint = 10000;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: widthSize,
              child: TextTitle(
                msg: "내 포인트 관리",
                clr: Theme.of(context).colorScheme.onBackground,
                ta: 1,
              ),
            ),
            SizedBox(
              width: widthSize,
              height: 40,
              child: Divider(
                thickness: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              height: 30,
            ),

            /*화면구성 02
            현재 잔여 포인트 확인하는 SizedBox - Row
             */
            BlocBuilder<MyinfoPageController, int>(builder: (context, state) {
              if (loadcheck) {
                beforePoint = state;

                didData(context, state - addPoint);
              } else {
                loadData(context, state - addPoint);
                loadcheck = true;
              }

              return SizedBox(
                width: widthSize,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextBig(
                        msg: "현재 잔여 포인트 : ",
                        clr: Theme.of(context).colorScheme.onBackground,
                        ta: 0,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextBig(
                        msg: "$state 원",
                        clr: Theme.of(context).colorScheme.onBackground,
                        ta: 2,
                      ),
                    )
                  ],
                ),
              );
            }), // 현재 잔여 포인트 확인하는 sizedbox - row 끝.
            /*화면구성 03
            충전할 포인트 넣으면 출력해주는 SizedBox - Row
             */
            BlocBuilder<PointChargerController, int>(builder: (context, state) {
              return SizedBox(
                width: widthSize,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextBig(
                        msg: "환전할 포인트 : ",
                        clr: Theme.of(context).colorScheme.onBackground,
                        ta: 0,
                      ),
                    ),
                    // addPoint = state;
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextBig(
                        msg: "$state 원",
                        clr: Theme.of(context).colorScheme.onBackground,
                        ta: 2,
                      ),
                    )
                  ],
                ),
              );
            }), // 충전할 포인트 확인하는 sizedbox - row 끝.

            /*화면구성 04
            최종 SizedBox - Row
             */
            BlocBuilder<PointChagingController, int>(builder: (context, state) {
              return SizedBox(
                width: widthSize,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextBig(
                        msg: "환전 후 포인트 : ",
                        clr: Theme.of(context).colorScheme.onBackground,
                        ta: 0,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextBig(
                        msg: "${state} 원",
                        clr: Theme.of(context).colorScheme.onBackground,
                        ta: 2,
                      ),
                    )
                  ],
                ),
              );
            }), // 충전할 포인트 확인하는 sizedbox - row 끝.

            SizedBox(
              height: 30,
            ),

            /*화면구성 5
            충전 금액 조절하는 버튼 만들기
             */

            SizedBox(
              width: widthSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.withAlpha(150),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (addPoint > 10000) {
                          addPoint = addPoint - 10000;
                          subPoints(context, beforePoint - addPoint);
                        } else {
                          showWarning2(context);
                        }
                      },
                      child: Text(
                        "-10,000",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      )),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withAlpha(150),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (addPoint < beforePoint - 10000) {
                          addPoint = addPoint + 10000;
                          addPoints(context, beforePoint - addPoint);
                        } else {
                          showWarning(context);
                        }
                      },
                      child: Text(
                        "+ 10,000",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      )),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: widthSize,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    print("before : $beforePoint");
                    print("add : $addPoint");
                    doRefund(context, addPoint);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: widthSize * 0.2,
                          child: Icon(
                            Icons.credit_card_sharp,
                            size: 30,
                          )),
                      SizedBox(
                          width: widthSize * 0.3,
                          child: TextMiddle(
                            msg: "환전하기",
                            clr: Colors.white,
                            ta: 1,
                          ))
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: widthSize,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: widthSize * 0.2,
                          child: Icon(
                            Icons.arrow_back_sharp,
                            size: 30,
                          )),
                      SizedBox(
                          width: widthSize * 0.3,
                          child: TextMiddle(
                            msg: "돌아가기",
                            clr: Colors.white,
                            ta: 1,
                          ))
                    ],
                  )),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  } //end of widget

  //function
  loadData(BuildContext ctx, int amount) async {
    await ctx.read<MyinfoPageController>().loadMyPoints();
  }

  addPoints(BuildContext ctx, int amount) async {
    await ctx.read<PointChargerController>().addPoint();
    await ctx.read<PointChagingController>().changePoint(amount);
  }

  subPoints(BuildContext ctx, int amount) async {
    await ctx.read<PointChargerController>().subPoint();
    await ctx.read<PointChagingController>().changePoint(amount);
  }

  didData(BuildContext ctx, int amount) async {
    await ctx.read<PointChagingController>().changePoint(amount);
  }

  showWarning(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("환전 금액은 잔여포인트를 넘을 수 없습니다."),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("확인"))
            ],
          );
        });
  } //showWarning

  showWarning2(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("환전 금액은 0보다 작을 수 없습니다."),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("확인"))
            ],
          );
        });
  } //showWarning

  showSuccessDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("환전 완료"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: Text("확인"))
            ],
          );
        });
  } // end of successDialog

  showFailedDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("환전 실패"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: Text("확인"))
            ],
          );
        });
  }

//function
  doRefund(BuildContext ctx, int amount) async {
    try {
      await BalanceRepository().refundMyPoints(amount);
    } catch (e) {
      showFailedDialog(ctx);
    }

    showSuccessDialog(ctx);
  }
}//end of class