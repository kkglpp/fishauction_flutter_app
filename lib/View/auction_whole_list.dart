import 'package:fishauction_app/ViewModel_Controller/auctionimg_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auction_page_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auction_page_slider_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auction_whole_list_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/open_auction_img_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/open_auction_price_controller.dart';
import 'package:fishauction_app/Custom/auction_grid.dart';
import 'package:fishauction_app/Model_model/auction_model.dart';
import 'package:fishauction_app/View/auction_page.dart';
import 'package:fishauction_app/View/open_auction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionWholeList extends StatelessWidget {
  const AuctionWholeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlocBuilder<AuctionWholeListController, List<AuctionModel>>(
              builder: ((context, state) {
                if (state.isEmpty) {
                  loadData(context);
                  // print(state.length);
                }
                return state.isEmpty
                    // state : Auction 목록이다. 이게 비어있으면 그냥 기본 사진으로 로딩화면을 대체.
                    ? Image.asset("images/fishing_default.jpeg")
                    // state가 비어있지 않으면 GridView로 전체 경매 목록을 보여준다.
                    //SliverGriddDelegateWithFixedcrossAxisCount
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => loadData(context),
                          child: GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                              ),
                              children: [
                                for (int index = 0;
                                    index < state.length;
                                    index++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector( // 각 Gird (Card) 를 누르면 해당 경매의 상세페이지로 이동.
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return MultiBlocProvider(
                                            providers: [
                                              BlocProvider(
                                                  create: (context) =>
                                                      AuctionPageController()),
                                              BlocProvider(
                                                  create: (context) =>
                                                      AuctionPageSliderController(
                                                          10000)),
                                              BlocProvider(
                                                  create: (context) =>
                                                      AuctoinImgController())
                                            ],
                                            child: AuctionPage( 
                                              auctionid: state[index].auctionid,
                                              pic: state[index].pic,
                                            ),
                                          );
                                        },
                                        ), //end of builder,
                                      ).then((value) =>
                                          loadData(context)), //end of push,
                                      child: BlocProvider(
                                        create: (context) =>
                                            AuctoinImgController(),
// Gird (Card) 를 별도의 Widget 으로 만들어서 불러옴. custom / AuctionGrid.dart                                             
                                        child: AuctionGrid(
                                          title: state[index].title,
                                          fish: state[index].fish,
                                          price: state[index].pricenow,
                                          content: state[index].content,
                                          insertDate: state[index].insertdate,
                                          type: state[index].issuccessed,
                                          urlImg: state[index].pic,
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                        ),
                      );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 45,
        ),
        onPressed: () {
          openAuction(context);
        },
      ),
    );
  }

//function
  // 경매 목록을 갱신하는 함수.
  loadData(BuildContext context) async {
    await context.read<AuctionWholeListController>().loadAuctionList(context);
  }

  //새로운 경매를 시작하는 페이지로 이동하는 함수.
  openAuction(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => OpenAuctionImgController(null),
          ),
          BlocProvider(create: (context) => OpenAuctionPriceController(10000))
        ], child: const OpenAuctionPage());
      },
    )); //end of Navigator
  }
} //end of class
