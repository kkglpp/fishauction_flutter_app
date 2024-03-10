
import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/Repository/auctions_repository.dart';
import 'package:fishauction_app/Repository/bidded_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionWholeListController extends Cubit <List<AuctionModel>>{
  AuctionWholeListController():super([]);

  // AuctionListRepository auctionListRepository = AuctionListRepository() ;
  loadAuctionList() async{
    List<AuctionModel> rs = await AuctionsRepository().getWholeList();
    emit(rs);
  }


}