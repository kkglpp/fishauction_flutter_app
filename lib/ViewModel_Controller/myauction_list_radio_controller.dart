
import 'package:fishauction_app/Model_Repository/bidded_repository_impl.dart';
import 'package:fishauction_app/Model_model/done_auction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAuctionListRadioController
    extends Cubit<(String, List<DoneAuctionModel>)> {
      //두가지 변수를 한꺼번에 관리 시도해봄. 이럴땐 걍 다른 상태 관리를 쓰는게 나을 것도 같음.
  MyAuctionListRadioController() : super(("가져올 목록을 선택해 주세요.", []));

  void checkSelling(String type) async {
    var rs = await BiddedRepositroyImpl ().getMyAuctionList('selling');
    emit((rs.$1, rs.$2));
  }

  void checkbuying(String type) async {
    var rs = await BiddedRepositroyImpl ().getMyAuctionList('buying');
    emit((rs.$1, rs.$2));
  }
}
