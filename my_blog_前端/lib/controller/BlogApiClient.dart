import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_blog/model/Article.dart';
import 'package:my_blog/model/Chat.dart';
import 'package:my_blog/model/Comment.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/PersonRelation.dart';
import 'package:my_blog/model/Searchdata.dart';
import 'package:my_blog/model/Todo.dart';
import 'package:my_blog/model/User.dart';
/*
* 通过百度提供的接口获取个人信息、文件
* */
class BlogApiClient {
  final HttpClient httpClient;
  BlogApiClient({HttpClient? httpClient}):this.httpClient=httpClient??HttpClient();
  final host = "192.168.242.1";
  Future<CommonResult> getUserInfo(String email, String password) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/user/login",
      {
        'email': "${email}",
        'password': "${password}"
      }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }
  // 获取验证码
  Future<CommonResult> getVerifyCode(String email) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/user/sendEmail",
        {
          'email': "${email}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }
  // 注册用户
  Future<CommonResult> registerUser(String username, String email, String password, String verifyCode) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/user/register",
        {
          'username': "${username}",
          'email': "${email}",
          'password': "${password}",
          'verifyCode': "${verifyCode}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }
  // 根据邮箱得到密码
  Future<CommonResult> getPassword(String email) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/user/getPassword",
        {
          'email': "${email}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }
  // 发布文章
  Future<CommonResult> releaseArticle({required String username, required String title, required String label, required String content, required String isPublic, required String plainText}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/article/add",
        {
          'username': username,
          'title': title,
          'label': label,
          'content': content,
          'isPublic': isPublic,
          'plainText': '${plainText}'
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }
  // 根据页号查询文章
  Future<List<Article>> getArticleByPage({required int pageNum}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/article/getArticleByPage",
        {
          'pageNum': "${pageNum}",
          'pageSize': "4",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Article> articles = [];
    if(json["code"] != 200) {
      return articles;
    }
    var listOfArticles = json['data']['list'] as List;
    listOfArticles.forEach((json) => articles.add(Article.fromJson(json)));
    return articles;
  }
  //上传文章封面图片到服务器
  Future<Response<dynamic>> uploadImage(File image, {String? username, String? title, String? label}) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      //"": "", //这里写其他需要传递的参数
      "file": await MultipartFile.fromFile(path, filename: name),
      "username": username,
      "title": title,
      "label": label
    });
    var response = Dio().post("http://192.168.242.1/article/imgupload", data: formData);
    return response;
  }
  // 获取当前用户是否对指定的文章点赞
  Future<CommonResult> getIsLove({int? articleId, String? username}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/collect/queryIsLove",
        {
          'articleId': "${articleId}",
          'username': "${username}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }
  // 改变点赞或取消点赞时该条记录的状态
  Future<CommonResult> changeIsLove({int? articleId, String? username, bool? isLove}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/collect/add",
        {
          'articleId': "${articleId}",
          'username': "${username}",
          'isLove': "${isLove}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  /*
  * 搜索文章时模糊查询文章
  * */
  Future<List<Article>> fuzzyQueryArticle({required String value}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/article/fuzzyquery",
        {
          'value': "${value}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Article> articles = [];
    if(json["code"] != 200) {
      return articles;
    }
    var listOfArticles = json['data'] as List;
    listOfArticles.forEach((json) => articles.add(Article.fromJson(json)));
    return articles;
  }

  // 改变搜索记录的搜索次数
  Future<CommonResult> changeSearch({String? value}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/search/change",
        {
          'value': "${value}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 查询指定的条数的热门搜索记录
  Future<List<Searchdata>> getHotSearch({int? cnt}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/search/hotSearch",
        {
          'cnt': "${cnt}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Searchdata> searchdatas = [];
    if(json["code"] != 200) {
      return searchdatas;
    }
    var listOfArticles = json['data'] as List;
    listOfArticles.forEach((json) => searchdatas.add(Searchdata.fromJson(json)));
    return searchdatas;
  }

  // 向数据库中存储用户的评论信息
  Future<CommonResult> addComment({String? author, String? title, String? label, String? username, String? content}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/comment/add",
        {
          'author': "${author}",
          'title': "${title}",
          'label': "${label}",
          'username': "${username}",
          'content': "${content}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 查询评论
  Future<List<Comment>> getAllComment({String? author, String? title, String? label}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/comment/query",
        {
          'author': "${author}",
          'title': "${title}",
          'label': "${label}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Comment> comments = [];
    if(json["code"] != 200) {
      return comments;
    }
    var listOfArticles = json['data'] as List;
    listOfArticles.forEach((json) => comments.add(Comment.fromJson(json)));
    return comments;
  }

  // 向数据库中存储任务
  Future<CommonResult> addTodo({String? username, String? title, String? content, int? priority, String? createDate, int? type}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/todo/add",
        {
          'username': "${username}",
          'title': "${title}",
          'content': "${content}",
          'priority': "${priority}",
          'createDate': "${createDate}",
          'type': "${type}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 修改数据库的任务记录
  Future<CommonResult> updateTodo({int? id, String? username, String? title, String? content, int? priority, String? createDate, int? type}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/todo/update",
        {
          'id': "${id}",
          'username': "${username}",
          'title': "${title}",
          'content': "${content}",
          'priority': "${priority}",
          'createDate': "${createDate}",
          'type': "${type}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 根据页号查询任务
  Future<List<Todo>> getTodoByPage({required int pageNum, required String username, required int type, required int status}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/todo/query",
        {
          'pageNum': "${pageNum}",
          'pageSize': "5",
          'username': "${username}",
          'type': "${type}",
          'status': "${status}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Todo> todos = [];
    if(json["code"] != 200) {
      return todos;
    }
    var listOfArticles = json['data']['list'] as List;
    listOfArticles.forEach((json) => todos.add(Todo.fromJson(json)));
    return todos;
  }

  // 根据任务号修改任务的状态
  Future<CommonResult> updateStatusById({required int id, required int status}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/todo/updateStatus",
        {
          'id': "${id}",
          'status': "${status}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 根据任务号删除任务
  Future<CommonResult> deleteTodo({required int id}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/todo/deleteById",
        {
          'id': "${id}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 查询用户收藏的文章
  Future<List<Article>> getCollectArticleByPage({required String username, required int pageNum}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/article/collect",
        {
          'username': "${username}",
          'pageNum': "${pageNum}",
          'pageSize': "4",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Article> articles = [];
    if(json["code"] != 200) {
      return articles;
    }
    var listOfArticles = json['data']['list'] as List;
    listOfArticles.forEach((json) => articles.add(Article.fromJson(json)));
    return articles;
  }

  // 查询用户自己的文章
  Future<List<Article>> getOwnArticle({required String username, required int isPublic}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/article/ownArticle",
        {
          'username': "${username}",
          'isPublic': "${isPublic}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Article> articles = [];
    if(json["code"] != 200) {
      return articles;
    }
    var listOfArticles = json['data'] as List;
    listOfArticles.forEach((json) => articles.add(Article.fromJson(json)));
    return articles;
  }

  // 根据文章序号删除文章
  Future<CommonResult> deleteArticle({required int id}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/article/deleteArticle",
        {
          'id': "${id}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 存储用户提交的意见
  Future<CommonResult> addOpinion({required String username, required String content}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/opinion/insert",
        {
          'username': "${username}",
          'content': "${content}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 根据用户名查询是否存在该用户
  Future<User?> queryFriend({required String username}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/user/queryUserByName",
        {
          'username': "${username}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    if(json["code"] != 200) {
      return null;
    }
    User user = User.fromJson(json['data']);
    return user;
  }

  // 添加好友
  Future<CommonResult> addFriend({required String myName, required String friendName}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/relation/addPerson",
        {
          'myName': "${myName}",
          'friendName': "${friendName}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 更改与好友之间的最后消息
  Future<CommonResult> updateMessage({required String myName, required String friendName, required String message}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/relation/update",
        {
          'myName': "${myName}",
          'friendName': "${friendName}",
          'message': "${message}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 查询好友列表
  Future<List<PersonRelation>> queryAllFriend({required String myName}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/relation/queryFriend",
        {
          'myName': "${myName}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<PersonRelation> relations = [];
    if(json["code"] != 200) {
      return relations;
    }
    var listOfArticles = json['data'] as List;
    listOfArticles.forEach((json) => relations.add(PersonRelation.fromJson(json)));
    return relations;
  }

  // 发送消息
  Future<CommonResult> sendMessage({required String sendUsername, required String receiveUsername, required String message}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/chat/sendMessage",
        {
          'sendUsername': "${sendUsername}",
          'receiveUsername': "${receiveUsername}",
          'message': "${message}"
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }

  // 获取用户和好友之间的所有消息
  Future<List<Chat>> queryAllMessage({required String sendUsername, required String receiveUsername}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/chat/queryAllMessage",
        {
          'sendUsername': "${sendUsername}",
          'receiveUsername': "${receiveUsername}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Chat> chats = [];
    if(json["code"] != 200) {
      return chats;
    }
    var listOfArticles = json['data'] as List;
    listOfArticles.forEach((json) => chats.add(Chat.fromJson(json)));
    return chats;
  }

  // 获取用户所有未接收的消息
  Future<List<Chat>> queryNoMessage({required String sendUsername, required String receiveUsername}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/chat/queryNoAccept",
        {
          'sendUsername': "${sendUsername}",
          'receiveUsername': "${receiveUsername}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    List<Chat> chats = [];
    if(json["code"] != 200) {
      return chats;
    }
    var listOfArticles = json['data'] as List;
    listOfArticles.forEach((json) => chats.add(Chat.fromJson(json)));
    return chats;
  }

  // 删除好友
  Future<CommonResult> deleteFriend({required String myName, required String friendName}) async {
    HttpClientRequest request = await httpClient.getUrl(Uri.http(
        host,
        "/relation/deleteLiaison",
        {
          'myName': "${myName}",
          'friendName': "${friendName}",
        }
    ));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();
    var json = jsonDecode(responseBody);
    return CommonResult.fromJson(json);
  }
}
