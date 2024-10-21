import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../const/widget.custom/custom_alerts.dart';

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