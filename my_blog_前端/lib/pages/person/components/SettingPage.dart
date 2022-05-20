import 'package:flutter/material.dart';
import 'package:my_blog/model/ThemeChangeEvent.dart';
import 'package:my_blog/pages/person/components/%20Feedback.dart';
import 'package:my_blog/pages/person/components/AboutPage.dart';
import 'package:my_blog/utils/Application.dart';
import 'package:my_blog/utils/ThemeUtils.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Map<String, Color> themeColorMap = {
    'redAccent': Colors.redAccent,
    'gray': Color(0xFF333333),
    'blue': Colors.blue,
    'blueAccent': Colors.blueAccent,
    'cyan': Colors.cyan,
    'deepPurple': Colors.deepPurple,
    'deepPurpleAccent': Colors.deepPurpleAccent,
    'deepOrange': Colors.deepOrange,
    'green': Colors.green,
    'lime': Colors.lime,
    'indigo': Colors.indigo,
    'indigoAccent': Colors.indigoAccent,
    'orange': Colors.orange,
    'amber': Colors.amber,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'red': Colors.red,
    'cyan': Colors.cyan,
    'teal': Colors.teal,
    'black': Colors.black,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
          new ExpansionTile(
            title: new Row(
              children: <Widget>[
                Icon(Icons.color_lens, color: Theme.of(context).primaryColor),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('主题'),
                )
              ],
            ),
            children: <Widget>[
              new Wrap(
                children: themeColorMap.keys.map((String key) {
                  Color? value = themeColorMap[key];
                  return new InkWell(
                    onTap: () {
                      ThemeUtils.currentThemeColor = value!;
                      Application.eventBus.fire(ThemeChangeEvent());
                    },
                    child: new Container(
                      margin: EdgeInsets.all(5.0),
                      width: 36.0,
                      height: 36.0,
                      color: value,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          new ListTile(
            trailing: Icon(Icons.chevron_right),
            title: new Row(
              children: <Widget>[
                Icon(Icons.feedback, color: Theme.of(context).primaryColor),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('意见反馈'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBackPage()));
            },
          ),
          new ListTile(
            trailing: Icon(Icons.chevron_right),
            title: Row(
              children: <Widget>[
                Icon(Icons.info, color: Theme.of(context).primaryColor),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('关于'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
            },
          ),
        ],
      ),
    );
  }
}
