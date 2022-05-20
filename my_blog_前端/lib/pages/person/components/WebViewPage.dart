import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

/// WebView 加载网页页面
class WebViewPage extends StatefulWidget {
  /// 标题
  String title;

  /// 链接
  String url;

  WebViewPage({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoad = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        elevation: 0.4,
        title: new Text(widget.title),
        bottom: new PreferredSize(
          child: SizedBox(
            height: 2,
            child: isLoad ? new LinearProgressIndicator() : Container(),
          ),
          preferredSize: Size.fromHeight(2),
        ),
        actions: <Widget>[
          IconButton(
            // tooltip: '用浏览器打开',
            icon: Icon(Icons.language, size: 20.0),
            onPressed: () {
              launchInBrowser(widget.url, title: widget.title);
            },
          ),
          IconButton(
            // tooltip: '分享',
            icon: Icon(Icons.share, size: 20.0),
            onPressed: () {
              Share.share('${widget.title} : ${widget.url}');
            },
          ),
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
      hidden: true,
    );
  }
  static Future<Null> launchInBrowser(String url, {String? title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
