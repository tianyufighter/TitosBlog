import 'package:flutter/material.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/model/Comment.dart';
import 'package:my_blog/pages/home/components/ArticleCard.dart';
import 'package:my_blog/pages/md/components/CommentCard.dart';


class CommentListWidget extends StatefulWidget {
  var commentList = <Comment>[];
  CommentListWidget({Key? key, required this.commentList}) : super(key: key);

  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  @override
  Widget build(BuildContext context) => _buildCommentWidget();
  Widget _buildCommentWidget() => widget.commentList.length == 0 ? Center(
    child: Column(
      children: <Widget>[
        Text("还没有评论，赶快去发布吧")
      ],
    ),
  ) : ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: widget.commentList.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildArticleItem(widget.commentList[index]);
    },
  );

  Widget _buildArticleItem(Comment comment) {
    return InkWell(
      child: CommentCard(comment: comment,),
      onTap: () {
      },
    );
  }
}
