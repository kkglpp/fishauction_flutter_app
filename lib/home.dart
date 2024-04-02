import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:fishauction_app/View/loginPage.dart';
import 'package:fishauction_app/View/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double? widthSize = ResponsiveValue(
            context,
            conditionalValues: [
              Condition.equals(name: MOBILE, value: 300.0),
              Condition.equals(name: TABLET, value: 400.0),
              Condition.equals(name: '2K', value: 500.0),
              Condition.equals(name: '4K', value: 600.0),
            ],).value ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const TextBig(msg: "Fish Auction Service"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black,width: 3,)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("images/fishing_default.jpeg",
                height: widthSize,
                width: widthSize,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  fixedSize: Size(widthSize!, widthSize!/10)
                ),                
                onPressed: ()=>move2Login(context),
                child: 
                const TextMiddle(msg: "로그인 하러가기",clr: Colors.red,ta: 1),
                ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0,10,0,0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  fixedSize: Size(widthSize, widthSize/10)
                ),
                onPressed: ()=>move2Register(context),
                child: 
                const TextMiddle(msg: "회원가입 하러가기",clr: Colors.blueAccent,ta: 1),
                ),
            ),
              

          ],
        ),
      ),


    );
  }//function


// 로그인페이지로 이동하기
move2Login(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context){
      return const LoginPage();
    })
  );
} //end of Move2Login

//회원가입 페이지로 이동하기
move2Register(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context){
      return RegisterPage();
    })
  );
} 



} // end of homeClass

