import 'package:fishauction_app/ViewModel_Controller/auctionimg_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/auction_page_controller.dart';
import 'package:fishauction_app/ViewModel_Controller/myauction_list_radio_controller.dart';
import 'package:fishauction_app/const/widget.custom/auction_card.dart';
import 'package:fishauction_app/const/widget.custom/text_middle.dart';
import 'package:fishauction_app/const/widget.custom/text_title.dart';
import 'package:fishauction_app/Model_model/done_auction_model.dart';
import 'package:fishauction_app/View/auction_done_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAuctionList extends StatelessWidget {
  const MyAuctionList({super.key});

  @override
  Widget build(BuildContext context) {
    int check =1;

    return Scaffold(
      body: BlocBuilder<MyAuctionListRadioController,
          (String, List<DoneAuctionModel>)>(builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 160,
                    height: 80,
                    child: RadioListTile(
                      title: TextMiddle(
                        msg: "판매 내역",
                        clr: Theme.of(context).colorScheme.onBackground,
                      ),
                      value: 1,
                      groupValue: check,
                      onChanged: (value) {
                        check = 1;
                        context
                            .read<MyAuctionListRadioController>()
                            .checkSelling("selling");
                      },
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    height: 80,
                    child: RadioListTile(
                      title: TextMiddle(
                        msg: "구매 내역",
                        clr: Theme.of(context).colorScheme.onBackground,
                      ),
                      value: 2,
                      groupValue: check,
                      onChanged: (value) {
                        check = 2;
                        context
                            .read<MyAuctionListRadioController>()
                            .checkbuying("buying");
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              /* 화면구성2 : 경매 목록 가져오기. 
              GridView
               */
              state.$1 != "success"
                  ? TextTitle(
                      msg: state.$1,
                      clr: Theme.of(context).colorScheme.onBackground,
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: state.$2.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) =>
                                                AuctionPageController(),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                AuctoinImgController(),
                                          ),
                                        ],
                                        child: AuctionDonePage(
                                            auctionid: int.parse(state
                                                .$2[state.$2.length -
                                                    (1 + index)]
                                                .auctionid)));
                                  },
                                ));
                              },
                              child: AuctionCard(
                                biddedid: state
                                    .$2[state.$2.length - (1 + index)].biddedid,
                                auctionid: state
                                    .$2[state.$2.length - (1 + index)]
                                    .auctionid,
                                buyerid: state
                                    .$2[state.$2.length - (1 + index)].buyerid,
                                biddedprice: state
                                    .$2[state.$2.length - (1 + index)]
                                    .biddedprice,
                                biddeddate: state
                                    .$2[state.$2.length - (1 + index)]
                                    .biddeddate,
                                address: state
                                    .$2[state.$2.length - (1 + index)].address,
                                deliverydate: state
                                    .$2[state.$2.length - (1 + index)]
                                    .deliverydate,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
