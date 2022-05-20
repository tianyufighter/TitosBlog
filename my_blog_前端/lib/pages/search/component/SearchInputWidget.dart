import 'package:flutter/material.dart';
/*
* 搜索界面中的顶部搜索框
* */
//由于组件获得输入焦点或提交搜索关键词时需要和其它组件交互  自定义两个回调函数
typedef SearchInputOnFocusCallback = void Function();
typedef SearchInputOnSubmittedCallback = void Function(String value);

// 搜索组件
class SearchInputWidget extends StatelessWidget {

  TextEditingController? textController;

  SearchInputOnFocusCallback? onTab;
  SearchInputOnSubmittedCallback? onSubmitted;

  SearchInputWidget({this.onSubmitted,this.onTab,this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: textController,
      onTap: onTab,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          hintText: '发现更多干货',
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left:0),
          border:OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)
          ) ,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black26,
          )

      ),
    );
  }
}
