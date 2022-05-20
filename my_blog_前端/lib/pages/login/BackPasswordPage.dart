import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';

/*
* 百度网盘登录界面
* */
class BackPasswordPage extends StatefulWidget {
  const BackPasswordPage({Key? key}) : super(key: key);

  @override
  _BackPasswordPageState createState() => _BackPasswordPageState();
}

class _BackPasswordPageState extends State<BackPasswordPage> {
  var _email = "";
  var _accountController = TextEditingController();
  final BlogApiClient apiClient = BlogApiClient();
  /*
  * 账户输入框
  * */
  Widget AccountEditTextField() {
    return TextFormField(
      controller: _accountController,
      decoration: InputDecoration(
        labelText: 'Email Address',
      ),
      validator: (String? value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value!)) {
          return '请输入正确的邮箱地址';
        }
      },
      onSaved: (String? value) => _email = value!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text("BackPassword"),
          ),
        ),
      body:
      Container(
        decoration: new BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/backgroundImage.jpg")
            )
        ),
        // margin: EdgeInsets.only(left: 40, right: 40),
        child: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: ListView(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '找回密码',
                          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
              ),
              SizedBox(height: 70,),
              AccountEditTextField(),
              SizedBox(height: 60,),
              RaisedButton(
                onPressed: () async {
                  CommonResult result = await apiClient.getPassword(_accountController.text);
                  if(result.code == 200) {
                    showDialog(
                        context: this.context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("消息"),
                            content: Text("密码已成功发送至了你的邮箱，请注意查收"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Text(
                                  "确 认",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                color: Colors.blue,
                              )
                            ],
                          );
                        }
                    );
                  } else {
                    showDialog(
                        context: this.context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("消息"),
                            content: Text("邮箱发送失败，请重新发送"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  _accountController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "确 认",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                color: Colors.blue,
                              )
                            ],
                          );
                        }
                    );
                  }
                },
                child: Text(
                  "获取密码",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                color: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}