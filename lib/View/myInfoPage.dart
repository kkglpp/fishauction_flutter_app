import 'package:fishauction_app/ViewModel_Controller/myInfoPage_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/pointChanging_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/pointCharger_controller.dart';
import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:fishauction_app/Custom/textTitle.dart';
import 'package:fishauction_app/View/pointChargingPage.dart';
import 'package:fishauction_app/View/pointRefundPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyinfoPage extends StatelessWidget {
  const MyinfoPage({super.key});

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

    return Scaffold(
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
            Spacer(),

            Icon(
              Icons.monetization_on_rounded,
              size: 200,
            ),
            SizedBox(
              height: 30,
            ),
            Spacer(),

            /*화면구성 02
            현재 잔여 포인트 확인하는 SizedBox - Row
             */
            SizedBox(
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
                  BlocBuilder<MyinfoPageController, int>(
                    builder: ((context, state) {
                      if (loadcheck) {
                      } else {
                        loadData(context);
                        loadcheck = true;
                      }

                      return SizedBox(
                        height: 50,
                        width: 150,
                        child: TextBig(
                          msg: "$state 원",
                          clr: Theme.of(context).colorScheme.onBackground,
                          ta: 2,
                        ),
                      );
                    }),
                  )
                ],
              ),
            ), // 현재 잔여 포인트 확인하는 sizedbox - row 끝.
            Spacer(),

            /*화면구성 03
            충전 및 환불하러 가는 버튼
             */
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(180),
                    minimumSize: Size(widthSize, 50)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Builder(builder: (context) {
                      return MultiBlocProvider(providers: [
                        BlocProvider(
                            create: (context) => MyinfoPageController(0)),
                        BlocProvider(
                            create: (context) => PointChargerController(10000)),
                        BlocProvider(
                            create: (context) => PointChagingController(0)),
                      ], child: const PointChargingPage());
                    } //end of builder
                        );
                  })).then((value) => loadData(context));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: widthSize * 0.3,
                      child: Icon(
                        Icons.credit_score_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: widthSize * 0.5,
                      child: TextMiddle(
                        msg: "포인트 충전/결재 하기",
                        clr: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ],
                )),

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondary.withAlpha(180),
                    minimumSize: Size(widthSize, 50)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Builder(builder: (context) {
                      return MultiBlocProvider(providers: [
                        BlocProvider(
                            create: (context) => MyinfoPageController(0)),
                        BlocProvider(
                            create: (context) => PointChargerController(10000)),
                        BlocProvider(
                            create: (context) => PointChagingController(0)),
                      ], child: const PointRefundPage());
                    } //end of builder
                        );
                  })).then((value) => loadData(context));                  



                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: widthSize * 0.3,
                      child: Icon(
                        Icons.currency_exchange_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: widthSize * 0.5,
                      child: TextMiddle(
                        msg: "포인트 환전하기",
                        clr: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  } //end of widget

  //function
  loadData(BuildContext ctx) async {
    await ctx.read<MyinfoPageController>().loadMyPoints();
  }
}
