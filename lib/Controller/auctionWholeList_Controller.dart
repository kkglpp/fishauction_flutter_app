
import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/Repository/auctionList_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionWholeListController extends Cubit <List<AuctionModel>>{
  AuctionWholeListController():super([]);

  AuctionListRepository auctionListRepository = AuctionListRepository() ;
  loadAuctionList() async{
    await auctionListRepository.getWholeList();
    emit(auctionListRepository.auctionList);
    // clearAuctionList();
  }


}