abstract class AuctionsRepository {

  openAuction(Map<String, String>? postdata);
  bidAuction(int aucID, int newPrice);
  getAuction(int auctionid);
  getWholeList();
}