import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auction_model.freezed.dart';
part 'auction_model.g.dart';

@freezed
class AuctionModel with _$AuctionModel{
  const factory AuctionModel({

  required int auctionid,
  required String seller_id,
  required String title,
  required String content,
  required String pic,
  required String fish,
  required int view,
  required int pricestart,
  required int pricenow,
  required String insertdate,
  required String? deletedate,
  required bool issuccessed,
  }) = _AuctionModel;

    factory AuctionModel.fromJson(Map<String, dynamic> json) => _$AuctionModelFromJson(json);



} // end of AuctionModel class