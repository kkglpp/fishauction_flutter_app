// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuctionModelImpl _$$AuctionModelImplFromJson(Map<String, dynamic> json) =>
    _$AuctionModelImpl(
      auctionid: json['auctionid'] as int,
      seller_id: json['seller_id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      pic: json['pic'] as String,
      fish: json['fish'] as String,
      view: json['view'] as int,
      pricestart: json['pricestart'] as int,
      pricenow: json['pricenow'] as int,
      insertdate: json['insertdate'] as String,
      deletedate: json['deletedate'] as String?,
      issuccessed: json['issuccessed'] as bool,
    );

Map<String, dynamic> _$$AuctionModelImplToJson(_$AuctionModelImpl instance) =>
    <String, dynamic>{
      'auctionid': instance.auctionid,
      'seller_id': instance.seller_id,
      'title': instance.title,
      'content': instance.content,
      'pic': instance.pic,
      'fish': instance.fish,
      'view': instance.view,
      'pricestart': instance.pricestart,
      'pricenow': instance.pricenow,
      'insertdate': instance.insertdate,
      'deletedate': instance.deletedate,
      'issuccessed': instance.issuccessed,
    };
