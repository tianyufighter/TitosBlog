import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/pages/home/components/LikeButtonWidget.dart';
import 'package:my_blog/utils/TimeUtils.dart';
import 'package:my_blog/utils/ToastUtil.dart';
/*
* 首页中每一篇文章的组件
* */
class ArticleCard extends StatefulWidget {
  String? articleUsername;
  String? createTime;
  String? title;
  String? content;
  String? label;
  String? imgPath;
  int? id;
  ArticleCard({Key? key, this.id, this.articleUsername, this.createTime, required this.title, this.content, this.label, required this.imgPath}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  final BlogApiClient apiClient = BlogApiClient();
  bool _isLove = false;
  _load() async {
    CommonResult result = await apiClient.getIsLove(articleId: widget.id, username: Constant.username);
    try {
      setState(() {
        if(result.code == 200) {
          _isLove = true;
        } else {
          _isLove = false;
        }
      });
    } catch(e) {

    }
  }
  @override
  void initState() {
    Future.delayed(Duration.zero, ()=>setState(() {
      _load();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:Border(bottom:BorderSide(width: 1,color: Color(0xffe5e5e5)) )
      ),
      child: InkWell(
        // onTap: () {
        //   print("点击了吧");
        // },
        child: InkWell(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Container(
                        width: 80,
                        height: 130,
                        child: widget.imgPath != null ? CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: widget.imgPath??"",
                          placeholder: (context, url) => new Center(
                            child: new SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: new CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        ) : Container(
                          child: Image.asset("assets/default_project_img.jpg", fit: BoxFit.fill,),
                        )
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                          child: Text(
                            'label: ${widget.label??""}',
                            style: TextStyle(fontSize: 12, color: Colors.cyan),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Text(
                            widget.title??"",
                            style: TextStyle(fontSize: 16),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Text(
                            widget.content??"",
                            style: TextStyle(
                              fontSize: 14,
                              // color: Colors.grey[600],
                              color: Colors.blueAccent,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.articleUsername??"",
                                style: TextStyle(
                                  fontSize: 12,
                                  // color: Colors.grey[600],
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                TimeUtils.getTimeStr(widget.createTime),
                                style: TextStyle(
                                  fontSize: 12,
                                  // color: Colors.grey[600],
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.fromLTRB(0, 1, 8, 8),
                          child: LikeButtonWidget(
                            isLike: _isLove,
                            onClick: () {
                              addOrCancelCollect(articleId: widget.id, username: Constant.username, isLove: !_isLove);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              // Divider(height: 1),
            ],
          ),
        ),
      )
    );
  }
  /// 添加收藏或者取消收藏
  void addOrCancelCollect({int? articleId, String? username, bool? isLove}) async {
    CommonResult result = await apiClient.changeIsLove(articleId: articleId, username: username, isLove: isLove);
    if(result.code == 200) {
      setState(() {
        _isLove = !_isLove;
        ToastUtil.show(msg: '${result.message}');
      });
    } else {
      ToastUtil.show(msg: "${result.message}");
    }
  }
}
