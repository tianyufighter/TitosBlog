import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/pages/home/components/ArticleCard.dart';
import 'package:my_blog/pages/todo/components/RefreshFooter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
/*
* 个人收藏的文章的界面
* */
class PersonCollect extends StatefulWidget {
  const PersonCollect({Key? key}) : super(key: key);

  @override
  _PersonCollectState createState() => _PersonCollectState();
}

class _PersonCollectState extends State<PersonCollect> {
  List<Article> _collectList = [];

  String _failMsg = "错误发生了，点击重新加载呢!";

  /// listview 控制器
  ScrollController _scrollController = new ScrollController();

  /// 是否显示悬浮按钮
  bool _isShowFAB = false;

  /// 页码，从0开始
  int _page = 1;

  final BlogApiClient apiClient = BlogApiClient();


  @override
  void initState() {
    super.initState();
    getCollectionList();
    _scrollController.addListener(() {
      /// 滑动到底部，加载更多
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("加载更多");
        // getMoreCollectionList();
      }
      if (_scrollController.offset < 200 && _isShowFAB) {
        setState(() {
          _isShowFAB = false;
        });
      } else if (_scrollController.offset >= 200 && !_isShowFAB) {
        setState(() {
          _isShowFAB = true;
        });
      }
    });
  }

  /// 获取收藏文章列表
  Future<Null> getCollectionList() async {
    _page = 1;
    apiClient.getCollectArticleByPage(username: Constant.username, pageNum: _page).then((articles) {
      try {
        setState(() {
          // 当前文章列表
          _collectList = articles;
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
  }

  /// 获取更多文章列表
  Future<Null> getMoreCollectionList() async {
    _page++;
    apiClient.getCollectArticleByPage(username: Constant.username, pageNum: _page).then((articles) {
      try {
        setState(() {
          // 当前文章列表
          _collectList = articles;
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
  }

  RefreshController _refreshController =
  new RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: Text("收藏"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: RefreshFooter(),
        controller: _refreshController,
        onRefresh: getCollectionList,
        onLoading: getMoreCollectionList,
        child: ListView.builder(
          itemBuilder: itemView,
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _collectList.length,
        ),
      ),
      floatingActionButton: !_isShowFAB ? null : FloatingActionButton(
        heroTag: "collect",
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          // 回到顶部时要执行的动画
          _scrollController.animateTo(0, duration: Duration(milliseconds: 2000), curve: Curves.ease);
        },
      ),
    );
  }

  Widget itemView(BuildContext context, int index) {
    Article item = _collectList[index];
    return InkWell(
      child: ArticleCard(id: item.id, articleUsername: item.username, createTime: item.createTime, title: item.title, content: item.plainText, label: item.label, imgPath: item.coverPhoto,),
      onTap: () {
      },
    );
  }
}
