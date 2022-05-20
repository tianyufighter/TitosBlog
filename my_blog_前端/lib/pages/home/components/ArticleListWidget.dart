import 'package:flutter/material.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/pages/home/components/ArticleCard.dart';

import 'ArticleCard.dart';

typedef ArticleListOnArticleTapCallback = void Function(Article file);
class ArticleListWidget extends StatefulWidget {
  var articleList = <Article>[];
  ArticleListOnArticleTapCallback onArticleTap;
  ArticleListWidget({Key? key, required this.articleList, required this.onArticleTap}) : super(key: key);

  @override
  _ArticleListWidgetState createState() => _ArticleListWidgetState();
}

class _ArticleListWidgetState extends State<ArticleListWidget> {
  @override
  Widget build(BuildContext context) => _buildFilesWidget();
  Widget _buildFilesWidget() => widget.articleList.length == 0 ? Center(
    child: Column(
      children: <Widget>[
        SizedBox(height: 200,),
        Image.asset('assets/file_add_btn_folder.png'),
        Text("还没有文章，赶快去发布吧")
      ],
    ),
  ) : ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: widget.articleList.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildArticleItem(widget.articleList[index]);
    },
  );

  Widget _buildArticleItem(Article article) {
    return InkWell(
      child: ArticleCard(id: article.id, articleUsername: article.username, createTime: article.createTime, title: article.title, content: article.plainText, label: article.label, imgPath: article.coverPhoto,),
      onTap: () {
        if(null != widget.onArticleTap) widget.onArticleTap(article);
      },
    );
  }
}
