import 'package:fishauction_app/Model_Repository/authRepository_impl.dart';

class LoginPageController{

  Future<bool> doLogin(String uid, String upw) async{
    AuthRepositoryImpl ari = AuthRepositoryImpl();
    bool rs = await ari.doLogin(uid, upw);
    return rs;
  }

}