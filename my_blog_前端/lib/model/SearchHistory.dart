import 'package:flutter/material.dart';
/*
* 在数据库中存储搜索记录的实体类
* */
class SearchHistory {
  int? id;
  late String keyword;
  late int? time;

  SearchHistory(this.keyword, {this.id, this.time});
  SearchHistory.fromMap(Map<String, dynamic> map) {
    this.keyword = map['keyword'];
    this.id = map['id'];
    this.time = map['time'];
  }
  Map<String, dynamic> toMap(SearchHistory t) {
    var map = <String, dynamic> {
      'keyword': t.keyword,
      'time': t.time ?? DateTime.now().millisecondsSinceEpoch,
    };
    if(t.id != null) {
      map['id'] = t.id;
    }
    return map;
  }
}