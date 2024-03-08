import 'dart:io';

import 'package:fishauction_app/Repository/auctionPage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OpenAuctionImgController extends Cubit<XFile?> {
  OpenAuctionImgController(super.initialState);
  final ImagePicker imgPicker = ImagePicker();

  selectImage() async {
    try{
    XFile? tmpFile = await imgPicker.pickImage(source: ImageSource.gallery);

    
    File imgFile = File(tmpFile!.path);
    
    // await AuctionPageRepository().predictRequest(imgFile.path);

    emit(tmpFile); }
    catch (e){
      emit(null);
    }
  } //selectImage

  openAuction(Map<String,String> postdata) async {

    AuctionPageRepository().openAuction(postdata);


  }

}//end of class
