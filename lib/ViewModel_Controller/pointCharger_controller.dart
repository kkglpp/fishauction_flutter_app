import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../Model_Repository/balanceRepository_impl.dart';
import '../Model_datahandler/staticforDatahandler.dart';

class PointChargerController extends Cubit<int> {
  PointChargerController(super.initialState);

  addPoint() {
    emit(state + 10000);
  }

  subPoint() {
    emit(state - 10000);
  }

  chargePoint(int amount) async {
    try{
    ResponseResult rs = await BalanceRepositoryImpl().chargeMyPoints(amount);
    }catch(e){
      Logger().e("Error in controller");
    }


  }
}
