import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/SearchHistory.dart';
/*
* 代表搜索的一条历史记录
* */
//定义与父组件交互的回调函数
typedef DeleteWidgetCallback = void Function(SearchHistoryWidget widget);
typedef SubmitWidgetCallback = void Function(String value);
class SearchHistoryWidget extends StatefulWidget {
  final SearchHistory history; // 该条搜索记录在数据库中表示的对象
  final DeleteWidgetCallback deleteWidget;
  final SubmitWidgetCallback submitWidget;
  //实现删除组件的功能，key是必要的
  SearchHistoryWidget(Key key,{required this.history,required this.deleteWidget, required this.submitWidget}) : super(key:key);

  @override
  _SearchHistoryWidgetState createState() => _SearchHistoryWidgetState(this.history.keyword);
}
class _SearchHistoryWidgetState extends State<SearchHistoryWidget> {
  // 历史记录的内容
  String title;

  _SearchHistoryWidgetState(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          widget.submitWidget(title);
        },
        child: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.restore, color: Colors.black38,),
                onPressed: () {}
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.black38,),
                onPressed: () {
                  widget.deleteWidget(widget);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
