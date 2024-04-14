import 'package:fishauction_app/Model_Repository/balanceRepository_impl.dart';
import 'package:fishauction_app/Model_datahandler/staticforDatahandler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointChagingController extends Cubit <int>{
  PointChagingController(super.initialState);

  changePoint(int newPoint){
    emit(newPoint);
  }




}