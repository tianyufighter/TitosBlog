import 'package:flutter/material.dart';
import 'package:my_blog/pages/login/LoginPage.dart';
/*
* 启动页面
* */
class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context)=>LoginPage()), (Route route)=>route == null
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // 屏幕宽度
        height: MediaQuery.of(context).size.height, // 屏幕高度,
        child: Image.asset(
          "assets/start.jpg", fit: BoxFit.cover
        )
      )
    );
  }

}
