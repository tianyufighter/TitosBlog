import 'package:flutter/material.dart';

class CommonResult<T> {
  int? code;
  String? message;
  T? data;
  CommonResult({this.code, this.message, this.data});
  CommonResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    return 'CommonResult{code: $code, message: $message, data: $data}';
  }
}