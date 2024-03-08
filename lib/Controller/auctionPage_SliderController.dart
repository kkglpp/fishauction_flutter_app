import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionPageSliderController extends Cubit <int>{
  AuctionPageSliderController(super.initialState);

  sliderChange(double num){
    emit(num.toInt());

  }

}