import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:processmanagement/Model/LoginUserData.dart';
import 'package:processmanagement/Model/Role.dart';
import 'package:processmanagement/other/ConstantColor.dart';
import 'package:processmanagement/other/Constants.dart';
import 'package:processmanagement/other/URL.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
@override
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginUserData loginUserData;
  Role role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantColor.APPBAR,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: new EdgeInsets.fromLTRB(40.0, 0, 40, 15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  stops: [
                0.5,
                0.7
              ],
                  colors: [
                ConstantColor.FIRSTLINEARGRADIENT,
                ConstantColor.SECONDLINEARGRADIENT
              ])),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 300,
                ),
                Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Theme(
                      data: ThemeData(
                          backgroundColor: Colors.white,
                          hintColor: Colors.green),
                      child: TextField(
                          controller: username,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                                fontSize: 15, color: Colors.grey[400]),
                            hintText: 'Enter Username',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          )),
                    )),
                Text(
                  ' Password',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Theme(
                    data: ThemeData(
                        backgroundColor: Colors.white, hintColor: Colors.green),
                    child: TextField(
                      controller: password,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        hintStyle:
                            TextStyle(fontSize: 15, color: Colors.grey[400]),
                        hintText: 'Enter Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45.0,
                  child: MaterialButton(
                    onPressed: () {
                      if(username.text.isEmpty)
                        {
                          _showSnakBarMsg("Enter Username.");
                        } if(password.text.isEmpty)
                        {
                          _showSnakBarMsg("Enter Password.");
                        }
                      else
                        {
                          // Navigator.pushNamed(context, '/FirstPage');

                          login();
                        }

                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.white,
                    highlightColor: Colors.orangeAccent,
                    color: Colors.white,
                    elevation: 4.0,
                    child: Text(
                      'Login',
                      style: TextStyle(color: ConstantColor.BUTTONCOLORTEXT),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: 220),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Developed by Techkumak',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 15),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Future<bool> login() async {

    showLoaderDialog(context);
    var params = {
      "user_name": username.text,
      "password": password.text,
    };

    http.Response response = await http.post(Uri.parse(URL.LOGIN),
        body: jsonEncode(params),
        headers: {"Content-Type": "application/json"});
    print(jsonEncode(params));

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    Navigator.pop(context);
    bool status = jsonResponse['status'];
    if (status) {
      Navigator.pushNamed(context, '/FirstPage');
      LoginUserData loginUserData = LoginUserData.fromJson(jsonResponse);
      SharedPreferences sharedUser = await SharedPreferences.getInstance();
      sharedUser.setInt(Constant.USER_ROLE, loginUserData.role.id);
      sharedUser.setInt(Constant.USER_ID, loginUserData.user.id);
    } else {
      _showSnakBarMsg("Incorrect Username or Password, Try again!");
    }

    return status;
  }
  void _showSnakBarMsg(String msg) {
    _scaffoldKey.currentState
    // ignore: deprecated_member_use
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Logging In...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}



// void _sendDataToSecondScreen() {
//     Navigator.pushNamed(context, '/Process');
// }
// void storeInDb(BuildContext context, LoginUserData loginUserData)
// {
//   print(loginUserData.password);
// }
