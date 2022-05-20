import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/model/Comment.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/pages/md/components/CommentListWidget.dart';
import 'package:my_blog/utils/ThemeUtils.dart';
import 'package:my_blog/utils/ToastUtil.dart';
import 'package:share/share.dart';

class MarkdownContent extends StatefulWidget {
  Article? article;
  MarkdownContent({Key? key, this.article}) : super(key: key);

  @override
  _MarkdownContentState createState() => _MarkdownContentState();
}

class _MarkdownContentState extends State<MarkdownContent> {
  String currentValue = '';
  List<Comment> _comments = [];
  final TextEditingController _commentController = new TextEditingController();
  final BlogApiClient apiClient = BlogApiClient();
  @override
  void initState() {
    apiClient.getAllComment(author: widget.article!.username, title: widget.article!.title, label: widget.article!.label).then((comments){
      setState(() {
        _comments = comments;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: Text("${widget.article!.title}",),
        actions: [
          IconButton(
            // tooltip: '分享',
            icon: Icon(Icons.share, size: 20.0),
            onPressed: () {
              // Share.share('${widget.title} : ${widget.url}');
              Share.share('${widget.article!.title} : http://www.baidu.com');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: ThemeUtils.dark ? null : DecorationImage(
                image: AssetImage("assets/b2.jpeg"),
                fit: BoxFit.cover
            )
        ),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                // border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
                border: Border(bottom: BorderSide(width: 1, color: Colors.black))
              ),
              height: MediaQuery.of(context).size.height*0.7,
              child: FutureBuilder(
                initialData: widget.article!.content,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return Markdown(data: snapshot.data);
                  } else {
                    return Center(
                      child: Text("加载中..."),
                    );
                  }
                },
              ),
            ),
            Text("评论: "),
            Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 40.0,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 6.0, right: 6.0, bottom: 4.0),
                    decoration: BoxDecoration(color: Color(0xfff0f0f0)),
                    child: TextFormField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "说点什么",
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 14.0, color: Color(0xff606266)),
                      // autofocus: true,
                      cursorColor: Color(0xff00c295),
                      scrollPadding: EdgeInsets.only(top: 0.0, bottom: 6.0),
                      minLines: 2,
                      maxLines: 3,
                      onChanged: (v) {
                        currentValue = v;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 4.0)),
                Row(
                  children: <Widget>[
                    Expanded(child: Text('')),
                    Container(
                        height: 30.0,
                        width: 40.0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          focusColor: Colors.white,
                          hoverColor: Colors.white,
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          child: Text(
                            '发布',
                            style: TextStyle(
                                color: Color(currentValue.length == 0
                                    ? 0xffbcbcbc
                                    : 0xff00c295)),
                          ),
                          onPressed: () {
                            if (currentValue == '') return;
                            _releaseCommentTap(currentValue);
                            setState(() {
                              currentValue = '';
                            });
                            _commentController.clear();
                          },
                        )
                    )
                  ],
                )
              ],
            ),
            // 评论部分
            CommentListWidget(commentList: _comments,)
          ],
        ),
      )
    );
  }
  /*
  * 点击发布评论按钮的事件
  * */
  void _releaseCommentTap(String value) async {
    CommonResult result = await apiClient.addComment(author: widget.article!.username, title: widget.article!.title, label: widget.article!.label, username: Constant.username, content: value);
    if(result.code == 200) {
      setState(() {
        apiClient.getAllComment(author: widget.article!.username, title: widget.article!.title, label: widget.article!.label).then((comments){
          setState(() {
            _comments = comments;
          });
        });
        ToastUtil.show(msg: '${result.message}');
      });
    } else {
      ToastUtil.show(msg: "${result.message}");
    }
  }
}
