import 'package:flutter/material.dart';
import 'package:my_blog/controller/BlogApiClient.dart';
import 'package:my_blog/model/CommonResult.dart';
import 'package:my_blog/model/Constant.dart';
import 'package:my_blog/pages/login/LoginPage.dart';
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
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _usernameController = TextEditingController(); // 用户名绑定controller
  var _emailController = TextEditingController(); // 邮箱绑定controller
  var _pwdController = TextEditingController(); // 密码绑定controller
  var _confirmController = TextEditingController(); // 确认密码输入框绑定controller
  var _verifyController = TextEditingController(); // 验证码输入框
  String _emailText = "";
  String _pwdText = "";
  String _confirmText = "";
  String _verifyText = "";
  final _formKey = GlobalKey<FormState>();
  bool _isObscure1 = true; // 控制是否显示密码的变量
  bool _isObscure2 = true;
  Color _eyeColor = Colors.blueGrey;
  final BlogApiClient apiClient = BlogApiClient();

  /*
  * 邮箱输入框
  * */
  Widget EmailEditTextField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email Address',
        prefixIcon: Icon(Icons.email)
      ),
      validator: (String? value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value!)) {
          return '请输入正确的邮箱地址';
        }
      },
      onSaved: (String? value) => _emailText = value!,
    );
  }
  /*
  * 用户名输入框
  * */
  Widget UsernameEditTextField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
          labelText: 'username',
          prefixIcon: Icon(Icons.person)
      ),
      validator: (String? value) {
        if(value == "") {
          return '请输入用户名';
        }
      },
      onSaved: (String? value) => _emailText = value!,
    );
  }
  /*
  * 密码输入框
  * */
  Widget PwdEditTextField(String text) {
    return TextFormField(
      controller: _pwdController,
      onSaved: (String? value) => _pwdText = value??"",
      obscureText: _isObscure1, // 控制密码输入的隐藏/显示
      validator: (String? value) {
        if (value!.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure1 = !_isObscure1;
                  _eyeColor = (_isObscure1
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color)!;
                });
              })),
    );
  }
  /*
  * 确认密码的输入框
  * */
  Widget ConfirmPwdEditTextField(String text) {
    return TextFormField(
      controller: _confirmController,
      onSaved: (String? value) => _confirmText = value??"",
      obscureText: _isObscure2, // 控制密码输入的隐藏/显示
      validator: (String? value) {
        if (value!.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure2 = !_isObscure2;
                  _eyeColor = (_isObscure2
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color)!;
                });
              })),
    );
  }
  Widget RegisterButton() {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '注册',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.blue,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState!.save();
              //TODO 执行登录方法
              // print('email:$_email , assword:$_password');
              print("username: ${_usernameController.text}, email: ${_emailText}, password: ${_pwdText}, confirmPassword: ${_confirmText}, verifyCode: ${_verifyText}");
              // 如果输入的密码和确认的密码不想当，则弹出弹出框提示用户
              if(_pwdText != _confirmText) {
                showDialog(
                    context: this.context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("提示"),
                        content: Text("两个密码不相等，请仔细检查"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "确 认",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            color: Colors.blue,
                          ),
                        ],
                      );
                    }
                );
              } else {
                if(_verifyText == "") {
                  showDialog(
                      context: this.context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("提示"),
                          content: Text("验证码为空，请仔细检查"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "确 认",
                                style: TextStyle(fontSize: 18.0),
                              ),
                              color: Colors.blue,
                            ),
                          ],
                        );
                      }
                  );
                } else {
                  // 向服务端发送请求
                  CommonResult result = await apiClient.registerUser(_usernameController.text, _emailController.text, _pwdController.text, _verifyController.text);
                  // 错误提示信息
                  String errmsg = "";
                  if(result.code == 200) {
                    errmsg = "注册成功，跳转到登录界面";
                  } else if(result.code == 401) {
                    errmsg = "注册失败，该邮箱或用户名已被注册";
                  } else if(result.code == 402) {
                    errmsg = "注册失败，验证码错误";
                  } else if(result.code == 403) {
                    errmsg = "注册失败，验证码已经失效";
                  } else if(result.code == 404) {
                    errmsg = "注册失败，没有获取验证码";
                  } else {
                    errmsg = "注册失败，信息有误";
                  }
                  showDialog(
                    context: this.context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("消息"),
                        content: Text("${errmsg}"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
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
                  if(result.code == 200) {
                    // 跳转到登录界面
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  }
                }
              }
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }
  /*
  * 注册模块
  * */
  Widget registerFunction() {
    return Column(
      children: [
        UsernameEditTextField(), // 用户名输入框
        EmailEditTextField(), // 邮箱输入框
        SizedBox(height: 10,),
        PwdEditTextField("Password"), // 密码输入框
        SizedBox(height: 10,),
        ConfirmPwdEditTextField("Confirm Password"),
        SizedBox(height: 30,),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _verifyController,
                onTap: (){},
                onSubmitted: (value) {
                  setState(() {
                    _verifyText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "验证码",
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 240, 240),
                  contentPadding: EdgeInsets.only(left: 0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  prefixIcon: Icon(
                    Icons.lock_open,
                    color: Colors.black26
                  )
                ),
              )
            ),
            SizedBox(width: 10,),
            RaisedButton(
              onPressed: () async {
                CommonResult result = await apiClient.getVerifyCode(_emailController.text);
                print("result = ${result}");
                if(result.code == 200) {
                  showDialog(
                      context: this.context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("消息"),
                          content: Text("验证码已成功发送，请及时接收"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
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
                } else {
                  showDialog(
                      context: this.context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("消息"),
                          content: Text("验证码发送失败，请重新获取验证码"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
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
                  "获取验证码",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              color: Colors.lightBlue,
            )
          ],
        ),
        SizedBox(height: 25,),
        RegisterButton(), // 登录按钮
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("RegisterPage"),
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
                    Container(
                    margin: EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset('assets/logo.png',width: 50,),
                          Text(
                            '欢迎注册tianyufighter博客',
                            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    registerFunction(),
                    SizedBox(height: 20,),
                    OtherLoginText(), // 其它登录方式的文字
                    OtherMethodLogin(), // 其它登录方式
                  ],
                ),
              )
          ),
        )
    );
  }
}