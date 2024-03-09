import 'package:fishauction_app/Custom/insertTextBox.dart';
import 'package:fishauction_app/Custom/textBig.dart';
import 'package:fishauction_app/Custom/textMiddle.dart';
import 'package:fishauction_app/Repository/auth_repository.dart';
import 'package:fishauction_app/View/tabbarViewPage.dart';
import 'package:flutter/material.dart';

class loginPage extends StatelessWidget {
  const loginPage({super.key});
  @override
  Widget build(BuildContext context) {
    
    TextEditingController idTec = TextEditingController();
    TextEditingController pwTec = TextEditingController();
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InsertTextBox(tec: idTec, content: "ID를 입력하세요."),
            InsertTextBox(
              tec: pwTec,
              content: "비밀번호를 입력하세요.",
              visibleStatus: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var loginrs =
                        await AuthRepository().doLogin(idTec.text, pwTec.text);
                    idTec.text = "";
                    pwTec.text = "";
                    loginAlert(context, loginrs);
                  },
                  style: ElevatedButton.styleFrom(fixedSize: Size(170, 50)),
                  child: TextMiddle(msg: "로그인", clr: Colors.red),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(fixedSize: Size(170, 50)),
                  child: TextMiddle(msg: "회원가입", clr: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } //end of widget build

  // Function
  loginAlert(BuildContext context, bool rs) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: TextBig(
              msg: rs ? "로그인 성공" : "로그인 실패",
              clr: Colors.blue,
            ),
            content: TextMiddle(
                ta: 0,
                clr: Theme.of(ctx).colorScheme.onBackground,
                msg: rs
                    ? "오늘도 오셨네요!\nauctionList 페이지로 이동합니다."
                    : "로그인에 실패하였습니다."),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();

                      if (rs) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const TabbarViewPage();
                        }));
                      }
                    },
                    child: const Text("확인")),
              ),
            ],
          );
        });
  }
} //end of loginPage
