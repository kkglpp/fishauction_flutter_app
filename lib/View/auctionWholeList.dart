import 'package:fishauction_app/ViewModel_Controller/auctionImg_Controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auctionPage_Controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auctionPage_SliderController.dart';
import 'package:fishauction_app/ViewModel_Controller/auctionWholeList_Controller.dart';
import 'package:fishauction_app/ViewModel_Controller/openAuctionImg_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/openAuctionPrice_controller.dart';
import 'package:fishauction_app/Custom/auctionGrid.dart';
import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/View/auctionPage.dart';
import 'package:fishauction_app/View/openAuctionPage.dart';
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
                  print(state.length);
                }
                return state.isEmpty
                    ? Image.asset("images/fishing_default.jpeg")
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => loadData(context),
                          child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5),
                              children: [
                                for (int index = 0;
                                    index < state.length;
                                    index++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
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
                                        }), //end of builder,
                                      ).then((value) =>
                                          loadData(context)), //end of push,
                                      child: BlocProvider(
                                        create: (context) =>
                                            AuctoinImgController(),
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

  loadData(BuildContext context) async {
    await context.read<AuctionWholeListController>().loadAuctionList();
  }

  openAuction(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => OpenAuctionImgController(null),
          ),
          BlocProvider(create: (context) => OpenAuctionPriceController(10000))
        ], child: OpenAuctionPage());
      },
    )); //end of Navigator
  }
}//end of class
