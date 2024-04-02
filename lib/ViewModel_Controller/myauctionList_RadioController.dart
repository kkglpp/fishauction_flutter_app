
import 'package:fishauction_app/Model_Repository/biddedRepository_impl.dart';
import 'package:fishauction_app/Model_model/doneAuction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAuctionListRadioController
    extends Cubit<(String, List<DoneAuctionModel>)> {
  MyAuctionListRadioController() : super(("가져올 목록을 선택해 주세요.", []));

  void checkSelling(String type) async {
    var rs = await BiddedRepositroyImpl ().getMyAuctionList(type);
    emit((rs.$1, rs.$2));
  }

  void checkbuying(String type) async {
    var rs = await BiddedRepositroyImpl ().getMyAuctionList(type);
    emit((rs.$1, rs.$2));
  }
}
