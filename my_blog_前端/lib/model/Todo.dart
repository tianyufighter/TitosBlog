import 'package:flutter/material.dart';

class Todo {
  int? id; // 任务的序号
  String? username; // 创建者的用户名
  String? title; // 任务标题
  String? content; // 任务的内容
  int? priority; // 优先级 0: 一般 1: 重要
  String? createDate; // 创建日期
  String? completeDate; // 完成日期
  int? status;
  int? type;

  Todo({
    this.id,
    this.username,
    this.title,
    this.content,
    this.priority,
    this.createDate,
    this.completeDate,
    this.status,
    this.type
  });

  Todo.fromJson(dynamic json) {
    id = json["id"];
    username = json["username"];
    title = json["title"];
    content = json["content"];
    priority = json["priority"];
    createDate = json["createDate"].split('T')[0];
    completeDate = json["completeDate"];
    status = json["status"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["username"] = username;
    map["title"] = title;
    map["content"] = content;
    map["priority"] = priority;
    map["createDate"] = createDate;
    map["completeDate"] = completeDate;
    map["status"] = status;
    map["type"] = type;
    return map;
  }

  @override
  String toString() {
    return 'Todo{id: $id, username: $username, title: $title, content: $content, priority: $priority, createDate: $createDate, completeDate: $completeDate, status: $status, type: $type}';
  }
}