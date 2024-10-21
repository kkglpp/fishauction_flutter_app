// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'done_auction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoneAuctionModelImpl _$$DoneAuctionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DoneAuctionModelImpl(
      biddedid: json['biddedid'] as int,
      auctionid: json['auctionid'] as String,
      buyerid: json['buyerid'] as String,
      biddedprice: (json['biddedprice'] as num).toDouble(),
      biddeddate: json['biddeddate'] as String,
      address: json['address'] as String,
      deliverydate: json['deliverydate'] as String?,
      paymentdate: json['paymentdate'] as String?,
    );

Map<String, dynamic> _$$DoneAuctionModelImplToJson(
        _$DoneAuctionModelImpl instance) =>
    <String, dynamic>{
      'biddedid': instance.biddedid,
      'auctionid': instance.auctionid,
      'buyerid': instance.buyerid,
      'biddedprice': instance.biddedprice,
      'biddeddate': instance.biddeddate,
      'address': instance.address,
      'deliverydate': instance.deliverydate,
      'paymentdate': instance.paymentdate,
    };
