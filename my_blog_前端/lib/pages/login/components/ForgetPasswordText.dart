import 'package:flutter/material.dart';
import 'package:my_blog/pages/login/BackPasswordPage.dart';

class ForgetPasswordText extends StatefulWidget {
  const ForgetPasswordText({Key? key}) : super(key: key);

  @override
  _ForgetPasswordTextState createState() => _ForgetPasswordTextState();
}

class _ForgetPasswordTextState extends State<ForgetPasswordText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BackPasswordPage()));
          },
        ),
      ),
    );
  }
}
