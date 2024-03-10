import 'package:fishauction_app/Controller/myauctionList_RadioController.dart';
import 'package:fishauction_app/Custom/auctionCard.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:fishauction_app/Custom/textTitle.dart';
import 'package:fishauction_app/Model/doneAuction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAuctionList extends StatelessWidget {
  const MyAuctionList({super.key});

  @override
  Widget build(BuildContext context) {
    var check ;


    return Scaffold(
      body: BlocBuilder<MyAuctionListRadioController, (String,List<DoneAuctionModel>)>(
          builder: (context, state) {

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
                        check =2;
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
              ?TextTitle(msg:state.$1)
              :
              Expanded(
                  child: ListView.builder(
                    itemCount: state.$2.length,
                    itemBuilder: (context, index) {
                      return
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AuctionCard(
                          biddedid: state.$2[state.$2.length-(1+index)].biddedid,
                          auctionid: state.$2[state.$2.length-(1+index)].auctionid,
                          buyerid: state.$2[state.$2.length-(1+index)].buyerid,
                          biddedprice: state.$2[state.$2.length-(1+index)].biddedprice,
                          biddeddate: state.$2[state.$2.length-(1+index)].biddeddate,
                          address: state.$2[state.$2.length-(1+index)].address,
                          deliverydate: state.$2[state.$2.length-(1+index)].deliverydate,
                          ),
                      );
                    },
                    )
              ),
            ],
          ),
        );
      }),
    );
  }
}
