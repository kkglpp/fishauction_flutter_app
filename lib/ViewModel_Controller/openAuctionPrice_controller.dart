import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OpenAuctionPriceController extends Cubit <int>{
  OpenAuctionPriceController(super.initialState);

  plusStartPrice(){

    emit(state+5000);
  }
  minusStartPrice(BuildContext ctx){
    if(state <= 10000){
      errorAlert(ctx);


    }else{

    emit(state-5000);
    }

  }

    errorAlert(BuildContext ctx) {

    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: TextBig(
              msg:  "시작가격을 더이상 낮출 수 없습니다.",
              clr: Colors.blue,
            ),
            content: TextMiddle(
                ta: 0,
                clr: Colors.black,
                msg:
                    "경매 시작 가격은 \n 최저 10,000원에서 시작하여야 합니다."
                    ),
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

}