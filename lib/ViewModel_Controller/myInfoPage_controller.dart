import 'package:fishauction_app/Repository/balanceRepository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyinfoPageController extends Cubit<int> {
  MyinfoPageController(super.initialState);

  loadMyPoints() async {
    int myPoints = await BalanceRepositoryImpl ().getMyPoints();
    print("loadMypoints");
    emit(myPoints);
  } //end of loadMyPoints
}//end of class
