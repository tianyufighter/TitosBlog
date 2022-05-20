import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/pages/login/components/ForgetPasswordText.dart';
import 'package:my_blog/pages/login/components/OtherLoginText.dart';
import 'package:my_blog/pages/login/components/OtherMethodLogin.dart';
import 'package:my_blog/pages/login/components/RegisterText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'components/TopWidget.dart';

/*
* 百度网盘登录界面
* */
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _accountController = TextEditingController();
  var _pwdController = TextEditingController();
  String _accountText = "";
  String _pwdText = "";
  bool _isEnableLogin = false;
  final _formKey = GlobalKey<FormState>();
  var _email = "";
  String _password = "";
  bool _isObscure = true;
  Color _eyeColor = Colors.blueGrey;
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
  /*
  * 密码输入框
  * */
  Widget PwdEditTextField() {
    return TextFormField(
      controller: _pwdController,
      onSaved: (String? value) => _password = value??"",
      obscureText: _isObscure,
      validator: (String? value) {
        if (value!.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = (_isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color)!;
                });
              })),
    );
  }
  Widget LoginButton() {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.blue,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState!.save();
              //TODO 执行登录方法
              // print('email:$_email , assword:$_password');
              CommonResult result = await apiClient.getUserInfo(_email, _password);
              if(result.message == "true") {
                Constant.username = result.data;
                Navigator.pushNamed(context, "/tabs");
              } else {
                showDialog(
                    context: this.context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("登录提醒"),
                        content: Text("邮箱或密码错误，请仔细检查!!!"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _accountController.clear();
                              _pwdController.clear();
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
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }
  /*
  * 登录模块
  * */
  Widget loginFunction() {
    return Column(
      children: [
        AccountEditTextField(), // 账户输入框
        SizedBox(height: 30,),
        PwdEditTextField(), // 密码输入框
        ForgetPasswordText(), // 忘记密码的登录方式
        LoginButton(), // 登录按钮
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text("LoginPage"),
          ),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                  // decoration: new BoxDecoration(color: Colors.white10),
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/backgroundImage.jpg")
                    )
                  ),
                  // margin: EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: ListView(
                      children: <Widget>[
                        TopWidget(), // 登录界面顶部logo和欢迎字样
                        SizedBox(height: 30,),
                        loginFunction(),
                        SizedBox(height: 40,),
                        OtherLoginText(), // 其它登录方式的文字
                        OtherMethodLogin(), // 其它登录方式
                        SizedBox(height: 15,),
                        RegisterText(), // 显示注册的链接
                      ],
                    ),
                  )
              ),
            )
    );
  }
}