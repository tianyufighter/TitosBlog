import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/pages/home/components/ArticleCard.dart';
import 'package:my_blog/pages/person/components/MyArticleCard.dart';
import 'package:my_blog/pages/todo/components/LoadingDialog.dart';
import 'package:my_blog/utils/ToastUtil.dart';


typedef ArticleListOnArticleTapCallback = void Function(Article file);
class MyArticleList extends StatefulWidget {
  var articleList = <Article>[];
  ArticleListOnArticleTapCallback onArticleTap;
  MyArticleList({Key? key, required this.articleList, required this.onArticleTap}) : super(key: key);

  @override
  _MyArticleListState createState() => _MyArticleListState();
}

class _MyArticleListState extends State<MyArticleList> {
  final BlogApiClient apiClient = BlogApiClient();

  /// 显示Loading
  _showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new LoadingDialog(
            outsideDismiss: false,
            loadingText: "loading...",
          );
        });
  }

  /// 隐藏Loading
  _dismissLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) => _buildFilesWidget();
  Widget _buildFilesWidget() => widget.articleList.length == 0 ? Center(
    child: Column(
      children: <Widget>[
        Image.asset('assets/ic_empty.png', height: 140,),
        Text("还没有文章，赶快去发布吧")
      ],
    ),
  ) : ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: widget.articleList.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildArticleItem(widget.articleList[index], index);
    },
  );

  Widget _buildArticleItem(Article article, int index) {
    return InkWell(
      child: MyArticleCard(id: article.id, articleUsername: article.username, createTime: article.createTime, title: article.title, content: article.plainText, label: article.label, imgPath: article.coverPhoto,deleteItemCallback: (_id) {this.deleteArticleById(_id, index);},),
      onTap: () {
        if(null != widget.onArticleTap) widget.onArticleTap(article);
      },
    );
  }
  /// 根据ID删除文章
  Future deleteArticleById(int _id, int index) async {
    _showLoading(context);
    CommonResult result = await apiClient.deleteArticle(id: _id);
    _dismissLoading(context);
    if(result.code == 200) {
      ToastUtil.show(msg: "删除成功");
      setState(() {
        widget.articleList.removeAt(index);
      });
    } else {
      ToastUtil.show(msg: "删除失败");
    }
  }
}
