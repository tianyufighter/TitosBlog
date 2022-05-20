import 'package:flutter/material.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/model/ThemeChangeEvent.dart';
import 'package:my_blog/pages/login/LoginPage.dart';
import 'package:my_blog/pages/person/components/MyArticlePage.dart';
import 'package:my_blog/pages/person/components/PersonCollect.dart';
import 'package:my_blog/pages/person/components/SettingPage.dart';
import 'package:my_blog/pages/todo/TodoPage.dart';
import 'package:my_blog/utils/Application.dart';
import 'package:my_blog/utils/ThemeUtils.dart';
import 'package:my_blog/utils/ToastUtil.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  String username = Constant.username;
  String level = "--"; // 等级
  String rank = "--"; // 排名
  String myScore = ''; // 我的积分

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: ThemeUtils.dark ? null : DecorationImage(
                image: AssetImage("assets/b2.jpeg"),
                fit: BoxFit.cover
            )
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(16, 40, 16, 10),
              color: Theme.of(context).primaryColor,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                    AssetImage("assets/ic_default_avatar.png"),
                    radius: 40.0,
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    child: Text(
                      username,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onTap: () {

                    },
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "我的收藏",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.favorite_border,
                  size: 24, color: Theme.of(context).primaryColor),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonCollect()));
              },
            ),
            ListTile(
              title: Text(
                "我的文章",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              leading: Image.asset(
                "assets/ic_share.png",
                width: 24,
                height: 24,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyArticlePage()));
              },
            ),
            ListTile(
              title: Text(
                "TODO",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              leading: Image.asset(
                "assets/ic_todo.png",
                width: 24,
                height: 24,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoPage()));
              },
            ),
            ListTile(
              title: Text(
                "夜间模式",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.brightness_2,
                  size: 24, color: Theme.of(context).primaryColor),
              onTap: () {
                setState(() {
                  changeTheme();
                });
              },
            ),
            ListTile(
              title: Text(
                "系统设置",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              leading: Icon(Icons.settings,
                  size: 24, color: Theme.of(context).primaryColor),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
              },
            ),
            Offstage(
              offstage: false,
              child: ListTile(
                title: Text(
                  "退出登录",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                leading: Icon(Icons.power_settings_new,
                    size: 24, color: Theme.of(context).primaryColor),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      // title: new Text(''),
                      content: new Text('确定退出登录吗？'),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: new Text('取消', style: TextStyle(color: Colors.cyan)),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            ToastUtil.show(msg: "已退出登录");
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return new LoginPage();
                                }
                            ));
                          },
                          child: Text('确定', style: TextStyle(color: Colors.cyan)),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
  /// 改变主题
  changeTheme() async {
    ThemeUtils.dark = !ThemeUtils.dark;
    Application.eventBus.fire(new ThemeChangeEvent());
  }
}
