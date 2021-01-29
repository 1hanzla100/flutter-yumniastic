import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Yumniastic/main.dart';
import 'dart:io';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;

  bool loading = false;

  void setToken(String token) async {
    await tokenStorage.write(key: "token", value: token);
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Yumniastic - Login",
          style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: loading == true
          ? Center(
              child: SpinKitThreeBounce(
                color: Colors.deepPurple,
                size: 50.0,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesome5Solid.user_circle),
                      labelText: "Enter Username",
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 12,
                    onChanged: (input) {
                      setState(() {
                        username = input;
                      });
                    },
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesome5Solid.key),
                      labelText: "Enter Password",
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 18,
                    onChanged: (input) {
                      setState(() {
                        password = input;
                      });
                    },
                  ),
                  RaisedButton.icon(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      void signin() async {
                        Response res = await post(
                            "https://yumniastic.herokuapp.com/api/token/",
                            body: json.encode(
                                {"username": username, "password": password}),
                            headers: {"Content-Type": "application/json"});
                        Map data = json.decode(res.body);
                        setState(() {
                          loading = false;
                        });
                        if (data['detail'] != null) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                            data['detail'],
                            style: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold),
                          )));
                        } else {
                          setToken(data['access']);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, "/loading_home");
                        }
                      }

                      if (username == null ||
                          username == "" ||
                          password == "" ||
                          password == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                          "Please Enter Required Data.",
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.bold),
                        )));
                      } else {
                        setState(() {
                          loading = true;
                        });

                        signin();
                      }
                    },
                    icon: Icon(
                      FontAwesome5Solid.sign_in_alt,
                      color: Colors.white,
                    ),
                    label: Text("Login"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
    );
  }
}
