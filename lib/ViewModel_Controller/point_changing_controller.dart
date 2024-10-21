import 'package:flutter_bloc/flutter_bloc.dart';

class PointChagingController extends Cubit <int>{
  PointChagingController(super.initialState);

  changePoint(int newPoint){
    emit(newPoint);
  }




}