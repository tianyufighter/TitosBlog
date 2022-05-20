import 'package:flutter/cupertino.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({Key? key}) : super(key: key);

  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  final _biggerFont = const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset('assets/logo.png',width: 80,),
          Text(
            '欢迎登录tianyufighter账户',
            style: _biggerFont,
          )
        ],
      ),
    );
  }
}
