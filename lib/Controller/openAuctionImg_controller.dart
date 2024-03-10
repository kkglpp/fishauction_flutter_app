import 'dart:io';

import 'package:fishauction_app/Repository/auctions_repository.dart';
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
    AuctionsRepository().openAuction(postdata);
  }
}//end of class
