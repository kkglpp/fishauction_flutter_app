import 'package:fishauction_app/Controller/auctionWholeList_Controller.dart';
import 'package:fishauction_app/Controller/myInfoPage_controller.dart';
import 'package:fishauction_app/Controller/myauctionList_RadioController.dart';
import 'package:fishauction_app/View/auctionWholeList.dart';
import 'package:fishauction_app/View/myAuctionList.dart';
import 'package:fishauction_app/View/myInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabbarViewPage extends StatelessWidget {
  const TabbarViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: SizedBox(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Transform(
                  transform: Matrix4.rotationY(3.14),
                  child: const Icon(
                    Icons.logout,
                    size: 40,
                  ),
                )),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(children: [
                  MultiBlocProvider(
                    providers: [
                      //리스트 목록을 가져오기 위한 컨트롤러
                      BlocProvider(
                          create: (context) => AuctionWholeListController()),
                    ],
                    child: const AuctionWholeList(),
                  ),
                  MultiBlocProvider(providers: [
                    BlocProvider(
                        create: (context) => MyAuctionListRadioController())
                  ], child: const MyAuctionList()),
                  BlocProvider(
                      create: (context) => MyinfoPageController(0),
                      child: const MyinfoPage())
                ]),
              ),
              TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.symmetric(vertical: 30),
                  indicatorColor: Theme.of(context).colorScheme.onBackground,
                  labelColor: Colors.amber,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Text(
                      "전체 경매 리스트",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    Text(
                      "내 경매 리스트",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    Text(
                      "포인트 관리",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
