import 'dart:io';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/HotWordBean.dart';
import 'package:my_blog/model/Searchdata.dart';
import 'package:my_blog/pages/home/components/ArticleListWidget.dart';
import 'package:my_blog/pages/md/MarkdownContent.dart';
import 'package:my_blog/utils/RandomColor.dart';
import 'package:my_blog/utils/ThemeUtils.dart';
import 'package:path/path.dart' as PathUtils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/SearchHistory.dart';
import 'component/SearchHistoryWidget.dart';
import 'component/SearchInputWidget.dart';
import 'function/DBHelper.dart';
/*
* 分别描述正在输入、搜索中、搜索结束、搜索为空、搜索失败集中状态
* */
enum SearchState {typing, loading, done, empty, fail}
/*
* 历史记录的点击事件，即状态
* */
enum SearchHistoryEvent {insert, delete, clear, search}
class SearchPage extends StatefulWidget {
  DBHelper searchHistoryProvider = DBHelper.instance;
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

typedef SearchInputOnFocusCallback = void Function();
typedef SearchInputOnSubmittedCallback = void Function(String value);

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textController = TextEditingController();// 文本控制器  用于清空文本框
  List<SearchHistoryWidget> widgetList = [];// 存储SearchHistoryWidget的列表
  List<SearchHistory> hisList = [];// 存储历史记录的列表
  SearchInputOnFocusCallback? onTap;
  SearchInputOnSubmittedCallback? onSubmitted;
  SearchState _searchState = SearchState.typing;
  var _searchResult = <Article>[]; // 存储查找的文件
  String _title = '根目录';// 记录当前目录的名称
  String _currPath = '/'; // 记录当前目录的位置
  String _failMsg = "";
  List<Searchdata> hotwordList = [];
  final BlogApiClient apiClient = BlogApiClient();

  _load() {
    apiClient.getHotSearch(cnt: 5).then((value){
      setState(() {
        hotwordList = value;
      });
    });
  }

  @override
  void initState(){
    // 读取本地存储的历史记录 并显示
    setState(() {
      widget.searchHistoryProvider
          .queryAll()
          .then((list){
        hisList = list;
        showHistory(hisList);
      });
    });
    Future.delayed(Duration.zero, ()=>setState(() {
      _load();
    }));
    super.initState();
  }
  // 搜索框提交事件
  void _onSubmittedSearch(value) async {
    if(value != "") {
      _searchState = SearchState.loading;
      // 搜索文件
      _onSubmittedSearchWord(value);
      // 添加到历史记录
      setState(() {
        // _searchState  = SearchState.loading;
        _textController.clear(); // 清空文本框
        widget.searchHistoryProvider.insert(new SearchHistory(value));
        // showHistory(hisList); // 显示列表文件
      });
    }
  }
  // 展示历史记录
  void showHistory(List<SearchHistory> list) {
    widgetList.clear();
    list.forEach((element){
      setState(() {
        widgetList.insert(0,SearchHistoryWidget(UniqueKey(),history: element, deleteWidget: (v) async{
          widget.searchHistoryProvider
              .delete(v.history.id)
              .then((value) => setState(() {
              hisList.remove(v.history);
              showHistory(hisList);
          }));

        }, submitWidget: (v){
          if(v != "") {
            // 搜索文件
            _onSubmittedSearchWord(v);
            setState(() {
              // _searchState  = SearchState.done;
              _searchState = SearchState.loading;
              showHistory(hisList); // 显示列表文件
            });
          }
        },));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0.0,
        title: Row(
          children: [
            Expanded(
              child: SearchInputWidget(onSubmitted: _onSubmittedSearch, textController: _textController,),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0,right: 15.0),
              child: InkWell(
                child: Text(
                  "取消",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: _buildPageBody(),
      )
    );
  }
  /*
  * 其界面主体根据搜索状态的改变动态显示的内容
  * */
   _buildPageBody() {
    switch (_searchState) {
      case SearchState.typing:
        return _buildSearchHistory();
      case SearchState.loading:
        return _buildLoadingWidget();
      case SearchState.done:
        return _buildSearchResult();
      case SearchState.fail:
      case SearchState.empty:
        return null;
    }
  }
  /*
  * 得到热门搜索关键词的列表
  * */
  List<Widget> getHotWordList() {
    List<Widget> widgets = [];
    // List<HotWordBean> list = [HotWordBean(name: '中国'), HotWordBean(name: '吃饭'), HotWordBean(name: '我很好'), HotWordBean(name: '你很有个性'), HotWordBean(name: '一起去旅行')];
    for(Searchdata item in hotwordList) {
      widgets.add(new InkWell(
        child: new Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: new Text(
            item.searchRecord??"",
            style: TextStyle(
              fontSize: 14.0,
              color: RandomColor.getColor(),
              fontStyle: FontStyle.italic
            ),
          ),
          labelPadding: EdgeInsets.only(left: 3.0, right: 3.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onTap: () {
          _onSubmittedSearch(item.searchRecord);
        }
      ));
    }
    return widgets;
  }
  /*
  * 输入框中正在输入数据时其页面显示的内容
  * */
  Widget _buildSearchHistory() {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15),
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "热门搜索",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 4,
                  alignment: WrapAlignment.start,
                  children: getHotWordList(),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15),
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "搜索历史",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black
                    ),
                  )
              ),
              SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: widgetList,
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 20,
        alignment: Alignment(0, -1),
        margin: EdgeInsets.only(bottom: 10.0),
        child: Stack(
          children: [
            InkWell(
              child: Text(
                "清空历史记录",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue
                ),
              ),
              onTap: ()async{
                widget.searchHistoryProvider
                .deleteAll()
                .then((value)=>setState((){
                    hisList.clear();
                    widgetList.clear();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
  /*
  * 查询文件时的等待界面
  * */
  Widget _buildLoadingWidget() {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              // margin: EdgeInsets.only(top: 260),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
              child: new CircularProgressIndicator(// 圆形进度条
                strokeWidth: 4.0,
                backgroundColor: Colors.blue,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Text("正在搜索"),
          ],
        )
      ],
    );
  }
  /*
  * 所有文件完成时且有文件，显示界面
  * */
  Widget _buildSearchResult() {
    // return FilesListWidget(this._searchResult, onFileTap: this._onTapDiskFile,);
    return ListView(
      children: [
        Column(
          children: [
            Container(
                padding: EdgeInsets.only(left: 20.0, top: 15.0, bottom: 15),
                alignment: Alignment(-1, 0),
                child: Text(
                          "搜索结果(${this._searchResult.length})",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                ),
                )
           ),
            SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                      children: [ArticleListWidget(articleList: _searchResult, onArticleTap: this._onArticleTap,)]
              ),
           )
           ),
        ],
        )
      ],
    );
  }
  /*
  * 点击搜索的文章时进入显示该文章界面
  * */
  void _onArticleTap(Article article) {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) {
          return MarkdownContent(article: article);
        }
    ));
  }
  /*
  * 搜索框输入完成后进行搜索的方法
  * */
  void _onSubmittedSearchWord(String value) async {
    widget.searchHistoryProvider.insert(new SearchHistory(value));
    CommonResult result = await apiClient.changeSearch(value: value);
    value = value.trim();
    if(value.isEmpty) return;
    List<Article> articles = await apiClient.fuzzyQueryArticle(value: value);
    setState(() {
      _searchState = SearchState.done;
      _searchResult = articles;
    });
  }
}
