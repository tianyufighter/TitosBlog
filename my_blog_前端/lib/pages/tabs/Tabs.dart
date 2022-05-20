import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_blog/pages/chat/ChatGroupListPage.dart';
import 'package:my_blog/pages/edit/EditorPage.dart';
import 'package:my_blog/pages/edit/components/ImagePickerPage.dart';
import 'package:my_blog/pages/home/HomePage.dart';
import 'package:my_blog/pages/person/PersonPage.dart';
/*
* 导航栏的切换控制
* */
class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList = [
    HomePage(),
    ChatGroupListPage(),
    EditorPage(),
    PersonPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('FlutterDemo'),),
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex, // 配置对应的索引值选中
        onTap: (int index) {
          setState(() { // 改变状态
            this._currentIndex = index;
          });
        },
        iconSize: 36.0, // icon的大小
        // fixedColor: Colors.red, // 选中的颜色
        type: BottomNavigationBarType.fixed, // 配置底部tabs可以有多个按钮
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("首页")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text("私信")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.create),
              title: Text("创作中心")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("我的")
          ),
        ],
      ),
    );
  }
}


