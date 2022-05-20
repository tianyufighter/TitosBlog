import 'package:flutter/material.dart';
import 'package:my_blog/pages/login/RegisterPage.dart';
/*
* 登录界面中跳转到注册界面的链接
* */
class RegisterText extends StatefulWidget {
  const RegisterText({Key? key}) : super(key: key);

  @override
  _RegisterTextState createState() => _RegisterTextState();
}

class _RegisterTextState extends State<RegisterText> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
