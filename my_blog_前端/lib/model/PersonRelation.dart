import 'package:flutter/material.dart';
/*
*   用户和好友的关系类
* */
class PersonRelation {
  String? friendName; // 好友的名字
  String? message; // 最后一条消息
  String? sendTime; // 最后一条消息的发送时间
  String? myName; // 我的名字
  String? friendPortrait; // 好友的头像
  String? myPortrait; // 我的头像

  PersonRelation({
    this.friendName,
    this.message,
    this.sendTime,
    this.myName,
    this.friendPortrait,
    this.myPortrait
  });

  PersonRelation.fromJson(dynamic json) {
    friendName = json["friendName"];
    message = json["message"];
    sendTime = json["sendTime"];
    myName = json["myName"];
    friendPortrait = json["friendPortrait"];
    myPortrait = json["myPortrait"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["friendName"] = friendName;
    map["lastMessage"] = message;
    map["sendTime"] = sendTime;
    map["myName"] = myName;
    map["friendPortrait"] = friendPortrait;
    map["myPortrait"] = myPortrait;
    return map;
  }

  @override
  String toString() {
    return 'PersonRelation{friendName: $friendName, message: $message, sendTime: $sendTime, myName: $myName, friendPortrait: $friendPortrait, myPortrait: $myPortrait}';
  }
}