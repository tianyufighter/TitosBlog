import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
/*
* 登录界面中的其它登录方式
* */
class OtherMethodLogin extends StatefulWidget {
  const OtherMethodLogin({Key? key}) : super(key: key);

  @override
  _OtherMethodLoginState createState() => _OtherMethodLoginState();
}

class _OtherMethodLoginState extends State<OtherMethodLogin> {
  List _loginMethod = [
    {
      "title": "qq",
      "icon1": FontAwesomeIcons.qq,
    },
    {
      "title": "wechat",
      "icon1": FontAwesomeIcons.weixin,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
        builder: (context) {
          return IconButton(
              icon: Icon(item['icon1'],
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                //TODO : 第三方登录方法
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("${item['title']}登录"),
                  action: new SnackBarAction(
                    label: "取消",
                    onPressed: () {},
                  ),
                ));
              });
        },
      ))
          .toList(),
    );
  }
}
