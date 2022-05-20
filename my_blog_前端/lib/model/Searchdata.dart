import 'package:flutter/material.dart';

class Searchdata {
  int? id;
  String? searchRecord;
  int? num;

  Searchdata({
    this.id,
    this.searchRecord,
    this.num
  });

  Searchdata.fromJson(dynamic json) {
    id = json["id"];
    searchRecord = json["searchRecord"];
    num = json["num"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["searchRecord"] = searchRecord;
    map["num"] = num;
    return map;
  }
}