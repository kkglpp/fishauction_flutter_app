import 'package:fishauction_app/Custom/text_big.dart';
import 'package:fishauction_app/Custom/text_middle.dart';
import 'package:fishauction_app/ViewModel_Controller/open_auction_price_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

errorAlert(BuildContext ctx) {
  showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const TextBig(
            msg: "시작가격을 더이상 낮출 수 없습니다.",
            clr: Colors.blue,
          ),
          content: const TextMiddle(
              ta: 0,
              clr: Colors.black,
              msg: "경매 시작 가격은 \n 최저 10,000원에서 시작하여야 합니다."),
          actions: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    ctx.read<OpenAuctionPriceController>().plusStartPrice();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("확인")),
            ),
          ],
        );
      });
}
