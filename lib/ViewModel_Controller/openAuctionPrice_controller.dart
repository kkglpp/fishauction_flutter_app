import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Custom/customAlerts.dart';

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


}