import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_blog/pages/person/components/WebViewPage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ComModel.dart';

class ComArrowItem extends StatelessWidget {
  /// 数据model
  final ComModel model;

  /// 点击回调函数
  final Function? onClick;

  const ComArrowItem(this.model, {Key? key, this.onClick}) : super(key: key);

  /// 跳转页面
  static void push(BuildContext context, Widget page) async {
    if (context == null || page == null) return;
    await Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (context) => page));
  }

  static Future<Null> launchInBrowser(String url, {String? title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// 跳转到 WebView 打开
  static void toWebView(BuildContext context, String title, String url) async {
    if (context == null || url.isEmpty) return;
    if (url.endsWith('.apk')) {
      launchInBrowser(url, title: title);
    } else {
      await Navigator.of(context)
          .push(new CupertinoPageRoute<void>(builder: (context) {
        return new WebViewPage(
          title: title,
          url: url,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Material(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          onTap: () {
            if (model.page != null) {
              push(context, model.page!);
            } else if (model.url != null) {
              toWebView(context, model.title??"", model.url??"");
            } else {
              onClick!();
            }
          },
          title: new Text(model.title == null ? '' : model.title!),
          subtitle: (model.subtitle == null || model.subtitle == '')
              ? null
              : new Text(
            model.subtitle == null ? '' : model.subtitle!,
            style: new TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          trailing: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                model.extra == null ? '' : model.extra!,
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              Offstage(
                offstage: model.isShowArrow == null ? true : !model.isShowArrow!,
                child: new Icon(Icons.chevron_right, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: new Border(
          bottom: BorderSide(
            width: 0.5,
            color: Color(0x1F000000),
          ),
        ),
      ),
    );
  }
}
