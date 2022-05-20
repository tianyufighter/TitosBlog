
import 'package:flutter/material.dart';
import 'package:my_blog/model/Comment.dart';
import 'package:my_blog/pages/edit/EditorPage.dart';

class CommentCard extends StatefulWidget {
  Comment? comment;
  CommentCard({Key? key, this.comment}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      // child: Text("${widget.comment!.username}: ${widget.comment!.content}"),
      child: Row(
        children: [
          Text("${widget.comment!.username}: ", style: TextStyle(
            color: Colors.blue
          ),),
          Text("${widget.comment!.content}", style: TextStyle(
            color: Colors.cyan
          ),)
        ],
      )
    );
  }
}
