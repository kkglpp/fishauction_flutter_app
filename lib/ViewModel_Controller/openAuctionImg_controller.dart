import 'dart:io';

import 'package:fishauction_app/Model_Repository/auctionsRepository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OpenAuctionImgController extends Cubit<XFile?> {
  OpenAuctionImgController(super.initialState);
  final ImagePicker imgPicker = ImagePicker();

  selectImage() async {
    try {
      XFile? tmpFile = await imgPicker.pickImage(source: ImageSource.gallery);
      // File imgFile = File(tmpFile!.path);
      emit(tmpFile);
    } catch (e) {
      emit(null);
    }
  } //selectImage

  openAuction(Map<String, String> postdata) async {
    AuctionsRepositoryImpl ().openAuction(postdata);
  }
}//end of class
