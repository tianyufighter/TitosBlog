import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/model/PersonRelation.dart';
import 'package:my_blog/pages/chat/components/GroupChatListBodyItem.dart';

class GroupChatListBody extends StatefulWidget {
  const GroupChatListBody({Key? key}) : super(key: key);

  @override
  _GroupChatListBodyState createState() => _GroupChatListBodyState();
}

class _GroupChatListBodyState extends State<GroupChatListBody> {
  // var chatList = <PersonRelation>[
  //   PersonRelation(friendName: '张三', message: '吃饭了吗?', timestamp: '2021-08-11', myName: 'Titos'),
  //   PersonRelation(friendName: '李四', message: '我去北京了', timestamp: '2021-08-10', myName: 'Titos'),
  //   PersonRelation(friendName: '王五', message: '好的，下次聊', timestamp: '2021-08-12', myName: 'Titos'),
  //   PersonRelation(friendName: '赵六', message: '很高兴认识你', timestamp: '2021-08-09', myName: 'Titos'),
  // ];
  List<PersonRelation> relationList = [];
  final BlogApiClient apiClient = BlogApiClient();
  // 定时任务
  Timer? _timer;

  _load() async {
    try {
      List<PersonRelation> res = await apiClient.queryAllFriend(myName: Constant.username);
      setState(() {
        relationList = res;
      });
    } catch(e) {
      _timer!.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      Future.delayed(Duration.zero, ()=>setState(() {
        _load();
      }));
    });
  }

  @override
  Widget build(BuildContext context) => _buildFilesWidget();
  Widget _buildFilesWidget() => relationList.length == 0 ? Center(
    child: Column(

    ),
  ) : ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: relationList.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildChatItem(relationList[index]);
    },
  );

  Widget _buildChatItem(PersonRelation chat) {
    return InkWell(
      child: GroupChatListBodyItem(
        friendName: chat.friendName,
        lastMessage: chat.message,
        timestamp: chat.sendTime,
        myName: chat.myName,
        friendPortrait: chat.friendPortrait,
        myPortrait: chat.myPortrait,
      ),
      onTap: () {
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    // 取消定时器
    _timer!.cancel();
  }
}
