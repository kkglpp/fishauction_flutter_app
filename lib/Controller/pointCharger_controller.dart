import 'package:flutter_bloc/flutter_bloc.dart';

class PointChargerController extends Cubit<int>{
  PointChargerController(super.initialState);

addPoint(){

  emit(state+10000);

}
subPoint(){

  emit(state-10000);

}



}