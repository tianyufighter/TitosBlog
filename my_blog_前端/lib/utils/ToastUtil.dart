import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

///
/// Toast 简单封装
///
class ToastUtil {
  static show({
    @required String? msg,
    Toast toastLength = Toast.LENGTH_SHORT,
    int timeInSecForIos = 1,
    double fontSize = 16.0,
    ToastGravity? gravity,
    Color backgroundColor = const Color(0xBA000000),
    Color textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
        msg: msg??"",
        toastLength: toastLength,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: timeInSecForIos,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
