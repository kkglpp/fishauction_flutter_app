// ignore_for_file: use_build_context_synchronously
import 'package:fishauction_app/const/widget.custom/text_big.dart';
import 'package:fishauction_app/Model_model/auction_model.dart';
import 'package:fishauction_app/Model_Repository/auctions_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionWholeListController extends Cubit<List<AuctionModel>> {
  AuctionWholeListController() : super([]);

  // AuctionsRepositoryImpl auctionsRepositoryImpl = AuctionsRepositoryImpl() ;
  loadAuctionList(BuildContext ctx) async {
    List<AuctionModel>? rs = await AuctionsRepositoryImpl().getWholeList();
    if (rs == null) {
      try {
        _showFailGetWholeList(ctx);//문제 발생해서 무한 로딩 될경우 alert 띄우고 페이지 이동하기.
      } catch (e) {
        return;
      }
      return;
    }
    emit(rs);
  }

  _showFailGetWholeList(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const TextBig(msg: "목록 가져오기 실패", clr: Colors.red,),
            content: const Text("목록을 가져오는 도중 문제가 발생했습니다.\n잠시 뒤 다시 시도하세요. \n문제가 지속될 경우 \n고객센터로 연락해 주시기바랍니다."),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                DefaultTabController.of(context).animateTo(1);
                  },
                  child: const Text("확인"))
            ],
          );
        });
  }
}
