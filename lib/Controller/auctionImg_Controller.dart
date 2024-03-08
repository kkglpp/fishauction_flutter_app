import 'dart:io';

import 'package:fishauction_app/Repository/auctionPage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctoinImgController extends Cubit <File?> {
  AuctoinImgController():super(null);

  loadImg(String filename) async {
    print("FileName : "+filename);
    File tmpfile = await AuctionPageRepository().downloadPic(filename);

    emit(tmpfile);

    
  }

}