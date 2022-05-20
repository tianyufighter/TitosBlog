import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Chat.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/PersonRelation.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'components/ChatMessage.dart';
import 'components/ImageZoomable.dart';

class ChatPage extends StatefulWidget {
  String? myName;
  String? friendName;
  String? friendPortrait;
  String? myPortrait;

  ChatPage({
    this.myName,
    this.friendName,
    this.friendPortrait,
    this.myPortrait
  });

  @override
  State createState() => new ChatPageState();
}

class ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin{
  // List messages = <Chat>[
  //   Chat(sendUsername: "张三", receiveUsername: "Titos", message: "hahaha"),
  //   Chat(sendUsername: "Titos", receiveUsername: "张三", message: "hahaha"),
  //   Chat(sendUsername: "张三", receiveUsername: "Titos", message: "hahaha"),
  //   Chat(sendUsername: "Titos", receiveUsername: "张三", message: "hahaha"),
  //   Chat(sendUsername: "张三", receiveUsername: "Titos", message: "hahaha"),
  //   Chat(sendUsername: "Titos", receiveUsername: "张三", message: "hahaha"),
  //   Chat(sendUsername: "Titos", receiveUsername: "张三", message: "hahaha"),
  // ];

  List messages = <Chat>[];

  static final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  final TextEditingController _textController = new TextEditingController();
  bool  _isComposing = false;
  final BlogApiClient apiClient = BlogApiClient();
  // listView 控制器
  ScrollController _scrollController = new ScrollController();
  // 定时任务
  Timer? _timer;

  // 查询所有消息
  _load() async {
    List<Chat> res = await apiClient.queryAllMessage(sendUsername: widget.friendName!, receiveUsername: widget.myName!);
    try {
      setState(() {
        messages = res.reversed.toList();
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        try {
          setState(() {
            _scrollController.jumpTo(
                _scrollController.position.minScrollExtent);
          });
        } catch(e) {

        }
      });
      _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
        Future.delayed(Duration.zero, ()=>setState(() {
          _queryNoAcceptMessage();
        }));
      });
    } catch(e) {

    }
  }

  /*
  * 查询所有未接收的消息
  * */
  _queryNoAcceptMessage() async {
    List<Chat> chats = await apiClient.queryNoMessage(sendUsername: widget.friendName!, receiveUsername: widget.myName!);
    if(chats.length != 0) {
      setState(() {
        messages.insertAll(0, chats.reversed);
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        });
      });
    }
  }

  @override
  void initState() {
    _load();
  }
  /*
  * 发送文本消息之前处理文本
  * */
  Future _handleSubmitted(String text) async {
    if(text.trim() == "") return;
    _textController.clear();
    _isComposing = false;
    _sendMessage(text:text, type: 0);
  }
  /*
  * 发送消息
  * type: 0 表示发送文本
  *       1 表示发送图片
  * */
  void _sendMessage({String? text, File? image, required int type}) async {
    Chat chat = Chat();
    if(type == 0) {
      CommonResult result = await apiClient.sendMessage(sendUsername: widget.myName!, receiveUsername: widget.friendName!, message: text!);
      apiClient.updateMessage(myName: widget.myName!, friendName: widget.friendName!, message: text);
      chat = Chat.fromJson(result.data);
    } else if(type == 1) {
      if (image == null) return null;
      String path = image.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(path, filename: name),
        "sendUsername": widget.myName,
        "receiveUsername": widget.friendName,
      });
      var response = await Dio().post("http://192.168.242.1/chat/sendPicture", data: formData);
      chat = Chat.fromJson(response.data["data"]);
    }
    setState(() {
      // messages.add(chat);
      messages.insert(0, chat);
    });
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   setState(() {
    //     _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    //   });
    // });
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
          title: new Text(widget.friendName!),
          centerTitle: true,
          elevation: 1.0,
          actions: <Widget>[
            new PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (value == "delete") {
                    CommonResult result = await apiClient.deleteFriend(myName: widget.myName!, friendName: widget.friendName!);
                    if(result.code == 200) {
                      _scaffoldKey.currentState!.showSnackBar(new SnackBar(
                        content: new Text("删除成功！"),
                      ));
                      Navigator.of(context).pop();
                    } else {
                      _scaffoldKey.currentState!.showSnackBar(new SnackBar(
                        content: new Text("删除失败！"),
                      ));
                    }
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                      value: "delete", child: new Text('删除会话')),
                ])
          ]),
      body: new Stack(children: <Widget>[
        new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: new Container(
              decoration: new BoxDecoration(),
            )),
        new Column(
          children: <Widget>[
            new Flexible(
              child: messages.length == 0 ? Center(

              ): ListView.builder(
                reverse: true,
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return new ChatMessage(
                    chat: messages[index],
                    myName: widget.myName,
                    friendPortrait: widget.friendPortrait,
                    myPortrait: widget.myPortrait,
                  );
                },
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            )
          ],
        )
      ]),
    );
  }

  /*
  *  底部输入消息的组件
  * */
  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 0),
                child: new IconButton(
                    icon: new Icon(Icons.photo),
                    onPressed: () async {
                      File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                      _sendMessage(image: imageFile, type: 1);
                    }),
              ),
              new Container(
                child: new IconButton(
                    icon: new Icon(Icons.photo_camera),
                    onPressed: () async {
                      File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                      _sendMessage(image: imageFile, type: 1);
                    }),
              ),
              new Flexible(
                  child: new TextField(
                    onTap: () {
                      // Future.delayed(const Duration(milliseconds: 240), () {
                      //   setState(() {
                      //     _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                      //   });
                      // });
                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 240),
                          curve: Curves.easeOut,
                        );
                      });
                    },
                    controller: _textController,
                    onChanged: (String text) {
                      setState(() {
                        _isComposing = text.length > 0;
                      });
                    },
                    onSubmitted: _handleSubmitted,
                    decoration: new InputDecoration.collapsed(hintText: '发送消息'),
                  )),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: _isComposing
                        ? () => _handleSubmitted(_textController.text)
                        : null),
              )
            ])));
  }
  @override
  void dispose() {
    super.dispose();
    // 取消定时器
    try {
      _timer!.cancel();
    } catch(e) {

    }
  }
}
