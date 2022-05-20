import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/utils/ThemeUtils.dart';
import 'package:zefyr/zefyr.dart';
import 'package:notus/convert.dart';
import 'package:zefyr/src/widgets/MyAppZefyrImageDelegate.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _labelController = new TextEditingController();
  final ZefyrController _zefyrController = new ZefyrController(NotusDocument());
  final FocusNode _focusNode = new FocusNode();
  String _title = "";
  String _label = "";
  var _delta;
  var json;
  var plainText;
  String string = '';
  String mk = ''; // 文章的markdown字符串
  int isPicture = 1; // 是否添加封面图片，默认为无封面图片
  //记录选择的照片
  File? _image;
  bool needPicture = true; // 控制选择封面图片的显示与隐藏
  final BlogApiClient apiClient = BlogApiClient();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _title = _controller.text;
      });
    });

    _labelController.addListener(() {
      setState(() {
        _label = _labelController.text;
      });
    });

    _zefyrController.document.changes.listen((change) {
      setState(() {
        _delta = _zefyrController.document.toDelta();
        json = _zefyrController.document.toJson();
        string = _zefyrController.document.toString();
        plainText = _zefyrController.document.toPlainText();
      });
    });

    super.initState();
  }

  void dispose() {
    _controller.dispose();
    _zefyrController.dispose();
    super.dispose();
  }

  _submit() {
    // print("====================================");
    // print("_delta: $_delta");
    // print("json:$json");
    // print("string:$string");
    // print("plainText: $plainText");
    // String mk = "";
    try {
      mk = notusMarkdown.encode(_delta);
    } catch(e) {
    }
    // print("mk:$mk");
    if(_title.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: '标题不能为空',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0
      );
    } else if(_label.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: '文章标签不能为空',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _getReleaseButtonPressed();
    }
  }
  //拍照
  Future _getImageFromCamera() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);
    setState(() {
      _image = image;
    });
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('写文章'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                _submit();
              },
              icon: Icon(
                Icons.near_me,
                color: Colors.white,
                size: 12,
              ),
              label: Text(
                '发布',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
          elevation: 1.0,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: ThemeUtils.dark ? null : DecorationImage(
              image: AssetImage("assets/b2.jpeg"),
              fit: BoxFit.cover
            )
          ),
          child: ZefyrScaffold(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView(
                children: <Widget>[
                  Text('输入标题：'),
                  Container(
                    decoration: null,
                    child: new TextFormField(
                      maxLength: 50,
                      controller: _controller,
                      decoration: new InputDecoration(
                        hintText: 'Title',
                      ),
                    ),
                  ),

                  Text('文章标签: '),
                  Container(
                    child: new TextFormField(
                      maxLength: 20,
                      controller: _labelController,
                      decoration: new InputDecoration(
                        hintText: 'Label',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("展示封面: "),
                        Text("无封面"),
                        Radio(
                          value: 1, // 按钮的值
                          onChanged: (value) { // 改变事件
                            dynamic a = value;
                            setState(() {
                              this.isPicture = a;
                              needPicture = true;
                            });
                          },
                          groupValue: this.isPicture, // 按钮组的值
                        ),
                        Text("单图"),
                        Radio(
                          value: 2,
                          onChanged: (value) {
                            dynamic a = value;
                            setState(() {
                              this.isPicture = a;
                              needPicture = false;
                            });
                          },
                          groupValue: this.isPicture,
                        )
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: needPicture,
                    child: Column(
                      children: [
                        /**
                         * 展示选择的图片
                         */
                        Container(
                          margin: EdgeInsets.only(right:260),
                          child: _image == null
                              ? Text("no image selected")
                              : Container(
                              height: 100,
                              child: Image.file(
                                _image!,
                                // fit: BoxFit.cover,
                              )
                          ),
                        ),
                        Row(
                          children: [
                            ButtonTheme(
                              height: 20,
                              minWidth: 20,
                              child: RaisedButton(
                                  onPressed: () {
                                    _getImageFromCamera();
                                  },
                                  child: Text("拍照")
                              ),
                            ),
                            SizedBox(width: 20,),
                            ButtonTheme(
                                height: 20,
                                minWidth: 20,
                                child: RaisedButton(
                                  onPressed: () {
                                    _getImageFromGallery();
                                  },
                                  child: Text("相册"),
                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text('内容：'),
                  Container(
                    decoration: BoxDecoration(
                        // color: Color(0xFFE1FFFF),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(width: 1, color: Colors.black38)
                    ),
                    child: _descriptionEditor(),
                  ),
                ],
              ),
            ),
          )),
        );
  }

  Widget _descriptionEditor() {
    final theme = new ZefyrThemeData(
      toolbarTheme: ToolbarTheme.fallback(context).copyWith(
          color: Colors.grey.shade800,
          toggleColor: Colors.grey.shade900,
          iconColor: Colors.white,
          disabledIconColor: Colors.grey.shade500,
      )
    );

    return ZefyrTheme(
      data: theme,
      child: ZefyrField(
        height: 400.0,
        decoration: InputDecoration(labelText: 'Description',hintStyle: TextStyle(
          fontSize: 200,
        )),
        controller: _zefyrController,
        focusNode: _focusNode,
        imageDelegate: MyAppZefyrImageDelegate(),
        // autofocus: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
  /*
  * 发布文章时弹出弹出框选择是否公开
  * */
  _getReleaseButtonPressed() {
    return showDialog(
          context: this.context,
          builder: (context) {
            return AlertDialog(
              title: Text("发布提醒"),
              content: Text("是否公开文章"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Tabs()));
                    CommonResult result = await apiClient.releaseArticle(username: Constant.username, title: _title, label: _label, content: mk, isPublic: "true", plainText: plainText);
                    if(result.code == 200) {
                      if(isPicture == 2 && needPicture == false) {
                        var result = await apiClient.uploadImage(_image!, username: Constant.username, title: _title, label: _label);
                      }
                      _controller.clear();
                      _labelController.clear();
                      _image = null;
                      this.isPicture = 1;
                      Fluttertoast.showToast(
                          msg: '文章发布成功',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: '文章发布失败',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "是",
                    style:TextStyle(fontSize: 18.0),
                  ),
                  color: Colors.blue,
                ),
                FlatButton(
                  onPressed: () async {
                    CommonResult result = await apiClient.releaseArticle(username: Constant.username, title: _title, label: _label, content: mk, isPublic: "false", plainText: plainText);
                    if(result.code == 200) {
                      if(isPicture == 2 && needPicture == false) {
                        var result = await apiClient.uploadImage(_image!, username: Constant.username, title: _title, label: _label);
                      }
                      _controller.clear();
                      _labelController.clear();
                      _image = null;
                      this.isPicture = 1;
                      Fluttertoast.showToast(
                          msg: '文章发布成功',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: '文章发布失败',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "否",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  color: Colors.blue,
                )
              ],
            );
          }
      );
  }
}

