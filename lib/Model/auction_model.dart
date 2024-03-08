class AuctionModel {
  late int auctionid;
  late String seller_id;
  late String title;
  late String content;
  late String pic;
  late String fish;
  late int view;
  late int pricestart;
  late int pricenow;
  late String insertdate;
  late String? deletedate;
  late bool issuccessed;
  get getAuctionid => this.auctionid;

  set setAuctionid(auctionid) => this.auctionid = auctionid;

  get sellerid => this.seller_id;

  set sellerid(value) => this.seller_id = value;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getContent => this.content;

  set setContent(content) => this.content = content;

  get getPic => this.pic;

  set setPic(pic) => this.pic = pic;

  get getFish => this.fish;

  set setFish(fish) => this.fish = fish;

  get getView => this.view;

  set setView(view) => this.view = view;

  get getPricestart => this.pricestart;

  set setPricestart(pricestart) => this.pricestart = pricestart;

  get getPricenow => this.pricenow;

  set setPricenow(pricenow) => this.pricenow = pricenow;

  get getInsertdate => this.insertdate;

  set setInsertdate(insertdate) => this.insertdate = insertdate;

  get getDeletedate => this.deletedate;

  set setDeletedate(deletedate) => this.deletedate = deletedate;

  get getIssuccessed => this.issuccessed;

  set setIssuccessed(issuccessed) => this.issuccessed = issuccessed;

  AuctionModel(
      {required this.auctionid,
      required this.seller_id,
      required this.title,
      required this.content,
      required this.pic,
      required this.fish,
      required this.view,
      required this.pricestart,
      required this.pricenow,
      required this.insertdate,
      required this.deletedate,
      required this.issuccessed});
} // end of AuctionModel class