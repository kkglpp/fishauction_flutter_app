import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/Repository/auctionsRepository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionPageController extends Cubit<AuctionModel?>{
  AuctionPageController():super(null);
  getAuction(int auctionid) async{
    AuctionModel? rs =  await AuctionsRepositoryImpl ().getAuction(auctionid);
    emit(rs);
  }





}