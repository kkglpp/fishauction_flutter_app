
abstract class Firebase_DataSource {
//env 파일에서 가져온 URL 주소.
  get(String addurl, Map<String, String>? headers);
  post(String addurl, dynamic data, {Map<String, String>? headers});
  put(String addurl, dynamic data, {Map<String, String>? headers});
  patch(String addurl, dynamic data, {Map<String, String>? headers});
  delete(String addurl, dynamic data, {Map<String, String>? headers});
} //end of DataSource
