import 'package:fishauction_app/View/tabbar_view_page.dart';
import 'package:fishauction_app/const/dataSource/datakey.dart';
import 'package:fishauction_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    checkToken;
  }

  void checkToken() async {
    const storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: RERESH_TOKEN_KEY);

    if (accessToken == null || refreshToken == null) {
      MaterialPageRoute(builder: (context) {
        return const Home();
      });
    } else {
      MaterialPageRoute(builder: (context) {
        return const TabbarViewPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/fishing_default.jpeg',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
