class DoneAuctionModel {
  late int biddedid;
  late String auctionid;
  late String buyerid;
  late int biddedprice;
  late String biddeddate;
  late String? address;
  late String? deliverydate;
  late String? paymentdate;
  get getBiddedid => this.biddedid;

  set setBiddedid(biddedid) => this.biddedid = biddedid;

  get getAuctionid => this.auctionid;

  set setAuctionid(auctionid) => this.auctionid = auctionid;

  get getBuyerid => this.buyerid;

  set setBuyerid(buyerid) => this.buyerid = buyerid;

  get getBiddedprice => this.biddedprice;

  set setBiddedprice(biddedprice) => this.biddedprice = biddedprice;

  get getBiddeddate => this.biddeddate;

  set setBiddeddate(biddeddate) => this.biddeddate = biddeddate;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getDeliverydate => this.deliverydate;

  set setDeliverydate(deliverydate) => this.deliverydate = deliverydate;

  get getPaymentdate => this.paymentdate;

  set setPaymentdate(paymentdate) => this.paymentdate = paymentdate;

  DoneAuctionModel({
    required this.biddedid,
    required this.auctionid,
    required this.buyerid,
    required this.biddedprice,
    required this.biddeddate,
    this.address,
    this.deliverydate,
    this.paymentdate,
  });
}
