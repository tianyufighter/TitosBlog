import 'package:flutter/material.dart';

class Article {
  int? id; // 文章的序号
  String? username; // 文章作者
  String? title; // 文章标题
  String? label; // 文章的标签
  String? content; // 文章的内容
  String? createTime; // 文章发布时间
  bool? isPublic; // 文章是否公开
  String? plainText; // 文章的内容的纯文本
  String? coverPhoto; // 文章封面的图片

  Article({
    this.id,
    this.username,
    this.title,
    this.label,
    this.content,
    this.createTime,
    this.isPublic,
    this.plainText,
    this.coverPhoto
  });

  Article.fromJson(dynamic json) {
    id = json["id"];
    username = json["username"];
    title = json["title"];
    label = json["label"];
    content = json["content"];
    createTime = json["createTime"];
    isPublic = json["isPublic"];
    plainText = json["plainText"];
    coverPhoto = json["coverPhoto"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["username"] = username;
    map["title"] = title;
    map["label"] = label;
    map["content"] = content;
    map["createTime"] = createTime;
    map["isPublic"] = isPublic;
    map["plainText"] = plainText;
    map["coverPhoto"] = coverPhoto;
    return map;
  }

  @override
  String toString() {
    return 'Article{id: $id, username: $username, title: $title, label: $label, content: $content, createTime: $createTime, isPublic: $isPublic, plainText: $plainText, coverPhoto: $coverPhoto}';
  }
}