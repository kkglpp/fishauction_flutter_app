
import 'package:fishauction_app/Model/auction_model.dart';
import 'package:fishauction_app/Repository/auctionsRepository_impl.dart';
import 'package:fishauction_app/Repository/biddedRepository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionWholeListController extends Cubit <List<AuctionModel>>{
  AuctionWholeListController():super([]);

  // AuctionListRepository auctionListRepository = AuctionListRepository() ;
  loadAuctionList() async{
    List<AuctionModel> rs = await AuctionsRepositoryImpl ().getWholeList();
    emit(rs);
  }


}