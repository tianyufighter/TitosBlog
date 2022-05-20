import 'package:flutter/material.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/model/PersonRelation.dart';
import 'package:my_blog/pages/chat/ChatPage.dart';
import 'package:my_blog/pages/chat/components/AddFriend.dart';
import 'package:my_blog/pages/chat/components/GroupChatListBody.dart';

class ChatGroupListPage extends StatefulWidget {
  const ChatGroupListPage({Key? key}) : super(key: key);

  @override
  _ChatGroupListPageState createState() => _ChatGroupListPageState();
}

class _ChatGroupListPageState extends State<ChatGroupListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("私信"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: new Container(
        child: GroupChatListBody(),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          onPressed: _floatingButtonCallback,
          child: new Icon(Icons.person_add))
    );
  }

  void _floatingButtonCallback() {
    try {
      showDialog(
          context: this.context,
          builder: (context) {
            return AddFriend(Constant.username);
          }
      );
    } catch(e) {

    }
  }
}
