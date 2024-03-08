// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AuctionCard extends StatelessWidget {
  final int biddedid;
  final String auctionid;
  final String buyerid;
  final int biddedprice;
  final String biddeddate;
  final String? address;
  final String? deliverydate;
  const AuctionCard({
    Key? key,
    required this.biddedid,
    required this.auctionid,
    required this.buyerid,
    required this.biddedprice,
    required this.biddeddate,
    this.address = "not yet",
    this.deliverydate = "not yet",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? heightSize = ResponsiveValue(
          context,
          conditionalValues: [
            Condition.equals(name: MOBILE, value: 80.0),
            Condition.equals(name: TABLET, value: 100.0),
            Condition.equals(name: '2K', value: 120.0),
            Condition.equals(name: '4K', value: 140.0),
          ],
        ).value ??
        80;

    return Container(
      height: heightSize,
      decoration: BoxDecoration(
          color: biddedprice > 100000 ? Colors.blueGrey : null,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextBig(
                      msg:
                          "구매 금액: ${NumberFormat('#,###').format(biddedprice)} 원 ",
                      clr: Theme.of(context).colorScheme.onBackground,
                      ta: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextMiddle(
                      msg:
                          "${biddeddate != null ? biddeddate!.split("T")[0] : '2023-11-11'}",
                      clr: Theme.of(context).colorScheme.onBackground,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            child: IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return MultiBlocProvider(
                  //       providers: [
                  //         BlocProvider(
                  //             create: (context) => AuctionPageController()),
                  //         BlocProvider(
                  //             create: (context) =>
                  //                 AuctionPageSliderController(10000)),
                  //       ],
                  //       child: AuctionPage(
                  //         auctionid: int.parse(auctionid),
                  //         title: "",
                  //         content: "",
                  //         seller: "",
                  //         priceNow: 000,
                  //         priceStart: 000,
                  //         insertDate: " ",
                  //         issuccessed: true,
                  //         pic: "",
                  //       ));
                  // }));
                },
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 60,
                )),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
