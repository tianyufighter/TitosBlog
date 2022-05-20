import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/pages/chat/ChatGroupListPage.dart';
import 'package:my_blog/pages/home/components/ArticleCard.dart';
import 'package:my_blog/pages/home/components/ArticleListWidget.dart';
import 'package:my_blog/pages/home/components/SwiperPage.dart';
import 'package:my_blog/pages/md/MarkdownContent.dart';
import 'package:my_blog/pages/search/SearchPage.dart';
import 'package:my_blog/utils/ThemeUtils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
enum ArticleState {loading, loaded, fail}
class _HomePageState extends State<HomePage> {
  // listView 控制器
  ScrollController _scrollController = new ScrollController();
  // 是否显示悬浮按钮
  bool _isShowFAB = false;
  // 页码，从1开始
  int _page = 1;
  String _failMsg = "错误发生了，点击重新加载呢!";
  ArticleState _articleState = ArticleState.loading;
  final BlogApiClient apiClient = BlogApiClient();
  List<Article> _articles = [];
  /*
  * 请求文章
  * */
  void  _requestArticle() {
    setState(()=>_articleState = ArticleState.loading);
    apiClient.getArticleByPage(pageNum: _page).then((articles) {
      try {
        setState(() {
          // 当前文章列表
          _articles = articles;
          // 改变文章的状态，表示文章加载完成
          _articleState = ArticleState.loaded;
        });
      } catch(e) {

      }

    }, onError: (e) {
      try {
        setState(() {
          // 当文章请求失败时，将其文章状态改为失败，并将错误信息记录
          _articleState = ArticleState.fail;
          _failMsg = e.toString();
        });
      } catch(e) {

      }
    });
  }
  @override
  void initState() {
    _scrollController.addListener(() {
      // 滑动到底部，加载更多
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _page++;
        apiClient.getArticleByPage(pageNum: _page).then((articles) {
          try {
            setState(() {
              // 当前文章列表
              _articles.addAll(articles);
            });
          } catch(e) {

          }

        }, onError: (e) {
          try {
            setState(() {
              _failMsg = e.toString();
            });
          } catch(e) {

          }
        });
        print("加载更多数据");
      }
      if(_scrollController.offset < 200 && _isShowFAB) {
        setState(() {
          _isShowFAB = false;
        });
      } else if(_scrollController.offset >= 200 && !_isShowFAB) {
        setState(() {
          _isShowFAB = true;
        });
      }
    });
    // 请求文章列表
    _requestArticle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: ChatPage(),
      appBar: AppBar(
        title: Text("首页"),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 5),
          child: Image.asset("assets/logo.png"),
        ),
        actions: [
          IconButton(
           icon: Icon(Icons.search),
           onPressed: () {
             Navigator.push(context, new MaterialPageRoute(
               builder: (BuildContext context) {
                 return new SearchPage();
               }
             ));
           },
          )
        ],
      ),
      body: Container(
        child: Container(
          child: ListView(
            controller: _scrollController,
            children: [
              SwiperPage(),
              Center(
                child: _buildArticleWidget(),
              )
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

  Widget _buildArticleWidget() {
    switch(_articleState) {
      case ArticleState.loading: // 文章正在加载时显示的界面
        return Column(
          children: <Widget>[
            SizedBox(height: 200,),
            CircularProgressIndicator(strokeWidth: 4.0,),
            Text("正在加载")
          ],
        );
      case ArticleState.loaded: // 文章加载完成时显示的界面
        return ArticleListWidget(articleList: _articles, onArticleTap: _onArticleTap);
      case ArticleState.fail: // 文章加载失败的显示界面
        return Column(
          children: <Widget>[
            SizedBox(height: 200,),
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 96,
              onPressed: _requestArticle,
            ),
            Text(_failMsg)
          ],
        );
    }
  }
  void _onArticleTap(Article article) {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) {
          return MarkdownContent(article: article);
        }
    ));
  }
}
