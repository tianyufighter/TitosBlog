import 'package:flutter/material.dart';

class TimeUtils {
  /*
  * 处理从服务器端获得的字符串
  * */
  static String getTimeStr(String? time) {
    var list = time!.split("T");
    return "${list[0]} ${list[1].substring(0, 5)}";
  }
}