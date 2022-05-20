import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/User.dart';
import 'package:my_blog/utils/ToastUtil.dart';
import 'dart:async';
import 'dart:math';

import 'ShowAwait.dart';

class AddFriend extends StatefulWidget {
  String? myName;
  AddFriend(this.myName);

  @override
  State createState() => new _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final TextEditingController _usernameController = new TextEditingController();
  String _searchUsername = "";
  String _searchEmail = "";
  String _searchMessages = "";
  String _searchPortrait = "";
  String _errorPrompt = "";
  bool _nullText = true;
  final BlogApiClient apiClient = BlogApiClient();

  void _handleAppend() {
    try {
      showDialog<int>(
          context: this.context,
          builder: (context) {
            return ShowAwait(_addSession());
          }
      ).then((value){
        ToastUtil.show(msg: "添加成功!");
        _searchUsername = "";
        Navigator.of(context).pop();
      });
    } catch(e) {

    }
  }

  void _handleFind() {
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
      if (_usernameController.text.isEmpty) {
        setState(() {
          _errorPrompt = "用户名不能为空！";
          _searchUsername = "";
        });
        return;
      } else if (_usernameController.text.trim() == widget.myName) {
        setState(() {
          _errorPrompt = "这是你的用户名哦！";
          _searchUsername = "";
        });
        return;
      } else if (_usernameController.text
          .trim()
          .length == 0) {
        setState(() {
          _errorPrompt = "用户名不能为空串！";
          _searchUsername = "";
        });
        return;
      }
      // 查询是否有输入的用户
      showDialog(
          context: this.context,
          builder: (context) {
            return ShowAwait(_findUser(_usernameController.text));
          }
      );
    } catch(e) {

    }
  }

  Future<int> _findUser(String username) async {
    User? user = await apiClient.queryFriend(username: username);
    if(user != null) {
      _searchUsername = user.username!;
      _searchEmail = user.email!;
      if(user.headImage != null) {
        _searchPortrait = user.headImage!;
      }
      setState(() {
        _errorPrompt = "";
      });
      return 1;
    } else {
      setState(() {
        _errorPrompt = "该用户不存在!";
        _searchUsername = "";
      });
      return 0;
    }
  }

  Future<int> _addSession() async {
    CommonResult result = await apiClient.addFriend(myName: widget.myName!, friendName: _searchUsername);
    if(result.code == 200) {
      _writeNewSession(widget.myName!, _searchUsername);
      _searchUsername = "";
      return 1;
    } else {
      return 0;
    }
  }

  void _writeNewSession(String myName, String friendName) async {
    CommonResult result = await apiClient.updateMessage(myName: myName, friendName: friendName, message: "一起来聊天吧");
  }

  @override
  Widget build(BuildContext context) {
    return new SimpleDialog(
        title: new Text("添加好友"),
        contentPadding: const EdgeInsets.symmetric(horizontal: 23.0),
        children: <Widget>[
          new Container(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Flexible(
                    child: new TextField(
                      controller: _usernameController,
                      // keyboardType: TextInputType.phone,
                      decoration:
                      new InputDecoration.collapsed(hintText: '点击此处输入用户名'),
                      onChanged: (text) {
                        if (text == "") {
                          _nullText = true;
                        } else {
                          _nullText = false;
                        }
                      },
                    )),
                _nullText
                    ? new Text("")
                    : new IconButton(
                  icon: new Icon(Icons.clear),
                  onPressed: () {
                    _errorPrompt = "";
                    _usernameController.clear();
                    _nullText = true;
                    _searchUsername = "";
                  },
                ),
              ],
            ),
            height: 40.0,
          ),
          new Container(
            child: _searchUsername == ""
                ? _errorPrompt == ""
                ? new Text("")
                : new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: new Text(
                  _errorPrompt,
                  style: new TextStyle(color: Colors.red),
                ))
                : new Row(
              children: <Widget>[
                new CircleAvatar(
                    // backgroundImage: new NetworkImage(_searchPortrait)),
                    backgroundImage: new AssetImage("assets/ic_default_avatar.png")),
                new Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "  " + _searchUsername,
                          textScaleFactor: 1.2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        new Text("  " + _searchEmail)
                      ],
                    ))
              ],
            ),
            height: 40.0,
          ),
          new Container(
              margin: const EdgeInsets.only(top: 19.0, bottom: 23.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new RaisedButton(
                    elevation: 0.0,
                    onPressed: () {
                      try {
                        Navigator.of(context).pop();
                      } catch(e) {

                      }
                    },
                    colorBrightness: Brightness.dark,
                    color: Theme.of(context).hintColor,
                    child: new Text('取消'),
                  ),
                  new RaisedButton(
                    elevation: 0.0,
                    onPressed:
                    _searchUsername == "" ? _handleFind : _handleAppend,
                    colorBrightness: Brightness.dark,
                    color: Theme.of(context).primaryColor,
                    child:
                    _searchUsername == "" ? new Text('查找') : new Text('添加'),
                  ),
                ],
              ))
        ]);
  }
}
