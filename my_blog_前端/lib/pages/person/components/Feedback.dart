
import 'dart:io';

import "package:dio/dio.dart";
import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:path/path.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _mEtController = new TextEditingController();
  final BlogApiClient apiClient = BlogApiClient();

  @override
  Widget build(BuildContext context) {
    //输入框
    Widget mBodyView() {
      return Expanded(
        //expande就是listview有多大就有多大,container就是container多大listview就有多大
        child: ListView(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                minHeight: 150,
              ),
              // color: Color(0xffffffff),
              color: Colors.black12,
              margin: EdgeInsets.only(top: 15),
              child: TextField(
                controller: _mEtController,
                // maxLines: 5,
                maxLines: 15,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: "快说点儿什么吧......",
                  hintStyle: TextStyle(color: Color(0xff999999), fontSize: 16),
                  contentPadding: EdgeInsets.only(left: 15, right: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
          appBar: AppBar(
            title: Text("意见反馈"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  CommonResult result = await apiClient.addOpinion(username: Constant.username, content: _mEtController.text);
                  if(result.code == 200) {
                    showDialog(
                        context: this.context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("消息"),
                            content: Text("意见已收到，我们将尽快处理，感谢您提出宝贵的意见😀"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  _mEtController.clear();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "确 认",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                color: Colors.blue,
                              )
                            ],
                          );
                        }
                    );
                  } else {
                    showDialog(
                        context: this.context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("消息"),
                            content: Text("服务器正忙，请稍后在重试"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  _mEtController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "确 认",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                color: Colors.blue,
                              )
                            ],
                          );
                        }
                    );
                  }
                },
              )
            ],
          ),
          body: Container(
              color: Colors.white,
              height: double.maxFinite,
              child: new Column(
                children: <Widget>[
                  mBodyView(),
                ],
              )),
    );
  }
}