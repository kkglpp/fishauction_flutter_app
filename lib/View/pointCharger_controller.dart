import 'package:flutter_bloc/flutter_bloc.dart';

class PointChargerController extends Cubit<int>{
  PointChargerController(super.initialState);

addPoint(){

  print("add");
  emit(state+10000);

}
subPoint(){

  print("sub");
  emit(state-10000);

}



}