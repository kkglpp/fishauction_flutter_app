
abstract class DatahandlerAuctions {

  get(String addurl, Map<String, String>? headers);
  post(String addurl, dynamic data, {Map<String, String>? headers});
  put(String addurl, dynamic data, {Map<String, String>? headers});
  patch(String addurl, dynamic data, {Map<String, String>? headers});
  delete(String addurl, dynamic data, {Map<String, String>? headers});
} //end of DataSource


