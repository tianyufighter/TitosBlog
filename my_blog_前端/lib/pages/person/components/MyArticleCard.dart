import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/pages/home/components/LikeButtonWidget.dart';
import 'package:my_blog/utils/TimeUtils.dart';
import 'package:my_blog/utils/ToastUtil.dart';
/*
* 我的文章中每一篇文章组件
* */
class MyArticleCard extends StatefulWidget {
  String? articleUsername;
  String? createTime;
  String? title;
  String? content;
  String? label;
  String? imgPath;
  int? id;
  /// 删除文章
  Function? deleteItemCallback;
  MyArticleCard({Key? key, this.id, this.articleUsername, this.createTime, required this.title, this.content, this.label, required this.imgPath, this.deleteItemCallback}) : super(key: key);

  @override
  _MyArticleCardState createState() => _MyArticleCardState();
}

class _MyArticleCardState extends State<MyArticleCard> {
  final BlogApiClient apiClient = BlogApiClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: new Border.all(width: 0.5),
                color: Colors.white10,
                borderRadius: new BorderRadius.circular((20.0))
            ),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
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
                                  color: Colors.lightBlue,
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
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                                    child: Text(
                                      'label: ${widget.label??""}',
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Text(
                                    TimeUtils.getTimeStr(widget.createTime),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // Divider(height: 1),
                ],
              ),
            )
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  // title: new Text(''),
                  content: new Text('确定删除吗？'),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child:
                      new Text('取消', style: TextStyle(color: Colors.cyan)),
                    ),
                    new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        widget.deleteItemCallback!(widget.id);
                      },
                      child:
                      new Text('确定', style: TextStyle(color: Colors.cyan)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
