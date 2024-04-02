import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doneAuction_model.freezed.dart';
part 'doneAuction_model.g.dart';

@freezed
class DoneAuctionModel with _$DoneAuctionModel {
  const factory DoneAuctionModel({

  required int biddedid,
  required String auctionid,
  required String buyerid,
  required double biddedprice,
  required String biddeddate,
  required String address,
  required String? deliverydate,
  required String? paymentdate,
  }) =_DoneAuctionModel;  

  factory DoneAuctionModel.fromJson(Map<String, dynamic> json) => _$DoneAuctionModelFromJson(json);
}