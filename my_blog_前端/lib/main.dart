import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/pages/edit/EditorPage.dart';
import 'package:my_blog/pages/edit/components/ImagePickerPage.dart';
import 'package:my_blog/pages/home/HomePage.dart';
import 'package:my_blog/pages/home/HomePage.dart';
import 'package:my_blog/pages/login/BackPasswordPage.dart';
import 'package:my_blog/pages/login/LoginPage.dart';
import 'package:my_blog/pages/login/RegisterPage.dart';
import 'package:my_blog/pages/md/MarkdownContent.dart';
import 'package:my_blog/pages/person/PersonPage.dart';
import 'package:my_blog/pages/person/components/PersonCollect.dart';
import 'package:my_blog/pages/person/components/SettingPage.dart';
import 'package:my_blog/pages/search/SearchPage.dart';
import 'package:my_blog/pages/start/StartPage.dart';
import 'package:my_blog/pages/tabs/Tabs.dart';
import 'package:my_blog/pages/todo/TodoPage.dart';
import 'package:my_blog/utils/Application.dart';
import 'package:my_blog/utils/ThemeUtils.dart';
import 'package:permission_handler/permission_handler.dart';

import 'model/ThemeChangeEvent.dart';
// import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  /** 主题模式 */
  late ThemeData themeData;

  @override
  void initState() {
    Application.eventBus = new EventBus();
    themeData = ThemeUtils.getThemeData();
    this.registerThemeEvent();
  }

  /// 注册主题改变事件
  void registerThemeEvent() {
    Application.eventBus
        .on<ThemeChangeEvent>()
        .listen((ThemeChangeEvent onData) => this.changeTheme(onData));
  }
  void changeTheme(ThemeChangeEvent onData) async {
    setState(() {
      themeData = ThemeUtils.getThemeData();
    });
  }
  // 检查是否有权限
  checkPermission() async {

    // 检查是否已有读写内存的权限
    bool status = await Permission.storage.isGranted;

    //判断如果还没拥有读写权限就申请获取权限
    if(!status) {
      return await Permission.storage.request().isGranted;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkPermission();
    return MaterialApp(
        title: "tianyufighter",
        debugShowCheckedModeBanner: false, // 去掉debug图标
        theme: themeData,
        routes: {
          '/login':(context)=>LoginPage(),
          '/homePage':(context)=>HomePage(),
          '/tabs':(context)=>LoginPage()
        },
        home: Tabs()
    );
  }
}
