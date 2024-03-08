// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fishauction_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' ;
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

void main() async {
  await dotenv.load(fileName:".env");
  Firebase.initializeApp();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const seedColor = Colors.cyanAccent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) =>
          ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: '2K'),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ]),

      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: seedColor,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.from(colorScheme: ColorScheme.dark()),
      home: const Home(),
      // home: const loginPage(),
      // home: const RegisterPage(),
      // home: const AuctionWholeList(),
      
      debugShowCheckedModeBanner: false,
    );
  }
}
