import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/Repository/auctionPage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionPageController extends Cubit<AuctionModel?>{
  AuctionPageController():super(null);

  AuctionPageRepository auctionPageRepository = AuctionPageRepository();


  getAuction(int auctionid) async{
    await auctionPageRepository.getAuction(auctionid);
    emit(auctionPageRepository.auction);
  }





}