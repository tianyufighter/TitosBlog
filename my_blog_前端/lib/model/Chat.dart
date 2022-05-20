import 'package:flutter/material.dart';
/*
* 消息的实体类
* */
class Chat {
  int? id; // 消息的序号
  String? sendUsername; // 消息发送者
  String? receiveUsername; // 消息接收者
  String? imageUrl; // 图片地址
  String? message; // 消息内容
  String? sendTime; // 消息发送时间
  bool? isComplete; // 消息是否完成交互

  Chat({
    this.id,
    this.sendUsername,
    this.receiveUsername,
    this.imageUrl,
    this.message,
    this.sendTime,
    this.isComplete
  });

  Chat.fromJson(dynamic json) {
    id = json["id"];
    sendUsername = json["sendUsername"];
    receiveUsername = json["receiveUsername"];
    imageUrl = json["imageUrl"];
    message = json["message"];
    sendTime = json["sendTime"];
    isComplete = json["isComplete"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sendUsername"] = sendUsername;
    map["receiveUsername"] = receiveUsername;
    map["imageUrl"] = imageUrl;
    map["message"] = message;
    map["sendTime"] = sendTime;
    map["isComplete"] = isComplete;
    return map;
  }

  @override
  String toString() {
    return 'Chat{id: $id, sendUsername: $sendUsername, receiveUsername: $receiveUsername, imageUrl: $imageUrl, message: $message, sendTime: $sendTime, isComplete: $isComplete}';
  }
}