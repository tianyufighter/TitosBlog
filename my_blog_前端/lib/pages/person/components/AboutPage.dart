import 'package:flutter/material.dart';

import 'ComArrowItem.dart';
import 'ComModel.dart';
/*
* 关于界面
* */
class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  ComModel version =
  new ComModel(title: '版本号', extra: '1.0.0', isShowArrow: false);
  ComModel officialAddress = new ComModel(
      title: '官方网站',
      subtitle: 'www.tianyufighter.cn',
      url: 'http://www.tianyufighter.cn',
      extra: '',
      isShowArrow: true);
  ComModel copyright =
  new ComModel(title: '版权声明', extra: '仅作个人学习使用', isShowArrow: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: Text("关于"),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 180.0,
            alignment: Alignment.center,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  child: new Image.asset(
                    "assets/logo.png",
                    width: 72.0,
                    fit: BoxFit.fill,
                    height: 72.0,
                  ),
                ),
                SizedBox(height: 10,),
                new Text(
                  "tianyufighter博客",
                  style: new TextStyle(fontSize: 20),
                ),
              ],
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Color(0x1F000000)
                )
              )
            ),
          ),
          new ComArrowItem(version),
          new ComArrowItem(officialAddress),
          new ComArrowItem(
            copyright,
            onClick: () {
              print("点击");
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('版权声明'),
                    content: Text(
                        ('本APP使用flutter技术实现,给用户带来更好的体验，谨参考学习')),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
