import 'dart:io';

import 'package:fishauction_app/Model_datahandler/firebase_datasource_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AuctoinImgController extends Cubit<File?> {
  AuctoinImgController() : super(null);

  loadImg(String filename) async {
    // print("controller : $filename \n ********");
    File? tmpfile = await FirebaseDataSourceImpl().downloadPic(filename);
    try {
      emit(tmpfile!);
    } catch (e) {
      Logger().e(e);
    }
  }
}
