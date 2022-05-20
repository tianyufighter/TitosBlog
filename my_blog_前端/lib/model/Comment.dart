import 'package:flutter/material.dart';

class Comment {
  int? id; // 评论序号
  String? author; // 文章作者名
  String? title; // 文章标题
  String? label; // 文章标签
  String? username; // 评论者
  String? content; // 评论内容
  String? releaseTime; // 评论时间

  Comment({
    this.id,
    this.author,
    this.title,
    this.label,
    this.username,
    this.content,
    this.releaseTime,
  });

  Comment.fromJson(dynamic json) {
    id = json["id"];
    author = json["author"];
    title = json["title"];
    label = json["label"];
    username = json["username"];
    content = json["content"];
    releaseTime = json["releaseTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["author"] = author;
    map["title"] = title;
    map["label"] = label;
    map["username"] = username;
    map["content"] = content;
    map["releaseTime"] = releaseTime;
    return map;
  }
}