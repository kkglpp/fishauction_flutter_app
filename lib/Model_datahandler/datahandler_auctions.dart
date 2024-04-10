
abstract class DatahandlerAuctions {

  get() ;
  postForOpenAuction(dynamic data);
  put(String addurl, dynamic data, {Map<String, String>? headers});
  patch(String addurl, dynamic data, {Map<String, String>? headers});
  delete(String addurl, dynamic data, {Map<String, String>? headers});
} //end of DataSource


