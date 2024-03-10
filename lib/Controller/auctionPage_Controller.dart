import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/Repository/auctions_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionPageController extends Cubit<AuctionModel?>{
  AuctionPageController():super(null);
  getAuction(int auctionid) async{
    AuctionModel? rs =  await AuctionsRepository().getAuction(auctionid);
    emit(rs);
  }





}