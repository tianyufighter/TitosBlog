import 'package:flutter/material.dart';

class User {
  int? id; // 用户序号
  String? email; // 用户邮箱
  String? password; // 用户密码
  String? username; // 用户名
  String? headImage; // 用户头像

  User({
    this.id,
    this.email,
    this.password,
    this.username,
    this.headImage
  });

  User.fromJson(dynamic json) {
    id = json["id"];
    email = json["email"];
    password = json["password"];
    username = json["username"];
    headImage = json["headImage"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["email"] = email;
    map["password"] = password;
    map["username"] = username;
    map["headImage"] = headImage;
    return map;
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, password: $password, username: $username, headImage: $headImage}';
  }
}