import 'package:fishauction_app/Repository/myPoints_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyinfoPageController extends Cubit<int> {
  MyinfoPageController(super.initialState);

  loadMyPoints() async {
    int myPoints = await MyPointsRepository().getMyPoints();
  print("loadMypoints");
    emit(myPoints);
  }//end of loadMyPoints

  chargMyPoints(int points)async{

    

    
  }


}//end of class
