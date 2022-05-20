import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/model/Todo.dart';
import 'package:my_blog/utils/ToastUtil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/Application.dart';
import 'components/ItemTodoList.dart';
import 'components/LoadingDialog.dart';
import 'components/RefreshFooter.dart';
import '../../model/RefreshTodoEvent.dart';
import 'TodoAddScreen.dart';
// 待办列表页面
class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  /// 待办类型：0:工作  1:学习  2:生活
  int todoType = Constant.todoIndex;
  int _page = 1;
  List<Todo> _todoBeanList = [];
  RefreshController _refreshController = new RefreshController(initialRefresh: false);
  /// listview 控制器
  ScrollController _scrollController = new ScrollController();
  /// 重新构建的数据集合
  Map<String, List<Todo>> map = Map();
  final SlidableController slidableController = SlidableController();
  /// 是否显示悬浮按钮
  bool _isShowFAB = false;
  final BlogApiClient apiClient = BlogApiClient();

  /// 注册刷新TODO事件
  void registerRefreshEvent() {
    Application.eventBus.on<RefreshTodoEvent>().listen((event) {
      try {
        setState(() {
          todoType = event.todoType;
          _todoBeanList.clear();
        });
      } catch(e) {}
      getNoTodoList();
    });
    getNoTodoList();
  }

  /// 显示Loading
  _showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new LoadingDialog(
            outsideDismiss: false,
            loadingText: "loading...",
          );
        });
  }

  /// 隐藏Loading
  _dismissLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    this.registerRefreshEvent();
  }

  /// 获取待办TODO列表数据
  Future getNoTodoList() async {
    _page = 1;
    List<Todo> result = await apiClient.getTodoByPage(pageNum: _page, username: Constant.username, type: todoType, status: 0);
    if(result.length > 0) {
      _refreshController.refreshCompleted(resetFooterState: true);
      try {
        setState(() {
          _todoBeanList.clear();
          _todoBeanList.addAll(result);
        });
      } catch(e) {}
      rebuildData();
    }
  }

  /// 获取更多待办TODO列表数据
  Future getMoreNoTodoList() async {
    _page++;
    List<Todo> result = await apiClient.getTodoByPage(pageNum: _page, username: Constant.username, type: todoType, status: 0);
    if(result.length > 0) {
      _refreshController.loadComplete();
      setState(() {
        _todoBeanList.addAll(result);
      });
      rebuildData();
    } else {
      _refreshController.loadNoData();
    }
  }

  /// 重新构建数据
  void rebuildData() {
    map.clear();
    Set<String> set = new Set();
    _todoBeanList.forEach((bean) {
      set.add(bean.createDate??"");
    });

    set.forEach((s) {
      List<Todo> list = [];
      map.putIfAbsent(s, () => list);
    });

    _todoBeanList.forEach((bean) {
      map[bean.createDate]!.add(bean);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: RefreshFooter(),
        controller: _refreshController,
        onRefresh: getNoTodoList,
        onLoading: getMoreNoTodoList,
        child: ListView.builder(
          itemBuilder: itemView,
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _todoBeanList.length,
        ),
      ),
      floatingActionButton: fWidget(),
    );
  }
  Widget? fWidget() {
    return _isShowFAB ? null : FloatingActionButton(
      heroTag: "todo_list",
      child: Icon(Icons.edit, color: Colors.white),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TodoAddScreen(
            todoType: todoType,
            editKey: 0,
          );
        }));
      },
    );
  }

  Widget itemView(BuildContext context, int index) {
    Todo item = _todoBeanList[index];
    bool isShowSuspension = false; // 控制该任务是否显示时间
    if (map.containsKey(item.createDate)) {
      if (map[item.createDate]!.length > 0) {
        if (map[item.createDate]![0].id == item.id) {
          isShowSuspension = true;
        }
      }
    }
    return ItemTodoList(
      isTodo: true,
      item: item,
      slidableController: slidableController,
      isShowSuspension: isShowSuspension,
      todoType: todoType,
      updateTodoCallback: (_id) {
        this.updateTodoState(_id, index);
      },
      deleteItemCallback: (_id) {
        this.deleteTodoById(_id, index);
      },
    );
  }
  /// 根据ID删除TODO
  Future deleteTodoById(int _id, int index) async {
    _showLoading(context);
    CommonResult result = await apiClient.deleteTodo(id: _id);
    _dismissLoading(context);
    if(result.code == 200) {
      ToastUtil.show(msg: "删除成功");
      setState(() {
        _todoBeanList.removeAt(index);
      });
      rebuildData();
    } else {
      ToastUtil.show(msg: "删除失败");
    }
  }

  /// 仅更新完成状态Todo
  Future updateTodoState(int _id, int index) async {
    // status: 0或1，传1代表未完成到已完成，反之则反之。
    _showLoading(context);
    CommonResult result = await apiClient.updateStatusById(id: _id, status: 1);
    _dismissLoading(context);
    if(result.code == 200) {
      ToastUtil.show(msg: "更新成功");
      setState(() {
        _todoBeanList.removeAt(index);
      });
    } else {
      ToastUtil.show(msg: "更新失败");
    }
  }
}
