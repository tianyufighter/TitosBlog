import 'package:flutter/material.dart';

class OtherLoginText extends StatefulWidget {
  const OtherLoginText({Key? key}) : super(key: key);

  @override
  _OtherLoginTextState createState() => _OtherLoginTextState();
}

class _OtherLoginTextState extends State<OtherLoginText> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }
}
