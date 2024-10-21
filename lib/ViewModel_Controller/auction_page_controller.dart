import 'package:fishauction_app/Model_model/auction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model_Repository/auctions_repository_impl.dart';

class AuctionPageController extends Cubit<AuctionModel?>{
  AuctionPageController():super(null);
  getAuction(int auctionid) async{
    AuctionModel? rs =  await AuctionsRepositoryImpl ().getAuction(auctionid);
    emit(rs);
  }





}