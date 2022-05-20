import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/pages/md/MarkdownContent.dart';
import 'package:my_blog/pages/person/components/MyArticleList.dart';
import 'package:my_blog/utils/ThemeUtils.dart';
/*
* 我的文章界面
* */
class MyArticlePage extends StatefulWidget {
  const MyArticlePage({Key? key}) : super(key: key);

  @override
  _MyArticlePageState createState() => _MyArticlePageState();
}

class _MyArticlePageState extends State<MyArticlePage> {
  // 个人公开的文章
  List<Article> pubArticles = [];
  // 个人私有的文章
  List<Article> priArticles = [];
  // listView 控制器
  ScrollController _scrollController = new ScrollController();
  // 是否显示悬浮按钮
  bool _isShowFAB = false;
  final BlogApiClient apiClient = BlogApiClient();

  @override
  void initState() {
    // 获取个人公开的文章
    apiClient.getOwnArticle(username: Constant.username, isPublic: 1).then((value) {
      setState(() {
        pubArticles = value;
      });
    });
    // 获取个人私有的文章
    apiClient.getOwnArticle(username: Constant.username, isPublic: 0).then((value) {
      setState(() {
        priArticles = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的文章"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: ThemeUtils.dark ? null : DecorationImage(
                image: AssetImage("assets/b2.jpeg"),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          child: ListView(
            controller: _scrollController,
            children: [
              Text("公开文章: "),
              MyArticleList(articleList: pubArticles, onArticleTap: _onArticleTap),
              Text("私密文章: "),
              MyArticleList(articleList: priArticles, onArticleTap: _onArticleTap)
            ],
          ),
        ),
      ),
      floatingActionButton: !_isShowFAB ? null : FloatingActionButton(
        heroTag: "home",
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          // 回到顶部时要执行的动画
          _scrollController.animateTo(0, duration: Duration(milliseconds: 2000), curve: Curves.ease);
        },
      ),
    );
  }
  /*
  * 点击文章进入文件的页面所执行的操作
  * */
  void _onArticleTap(Article article) {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) {
          return MarkdownContent(article: article);
        }
    ));
  }
}
