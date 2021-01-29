import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String username;
  String password;
  String address;
  String phone;

  bool loading = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Yumniastic - Signup",
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
                    "Signup",
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
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesome5Solid.address_card),
                      labelText: "Enter Address",
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 150,
                    onChanged: (input) {
                      setState(() {
                        address = input;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "+92",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Quicksand"),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(FontAwesome5Solid.phone),
                            labelText: "Enter Phone No.",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 10,
                          onChanged: (input) {
                            setState(() {
                              phone = input;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  RaisedButton.icon(
                    padding: EdgeInsets.all(10),
                    onPressed: () {
                      void signup() async {
                        Response res = await post(
                            "https://yumniastic.herokuapp.com/api/signup/",
                            body: json.encode({
                              "username": username,
                              "password": password,
                              "address": address,
                              "phone": phone
                            }));
                        String data = json.decode(res.body)['res'];
                        setState(() {
                          loading = false;
                        });
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                          data,
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              fontWeight: FontWeight.bold),
                        )));

                        // if (json.decode(res.body)['res'] ==
                        //     "Account Successfuly Created") {
                        //   Navigator.pushReplacementNamed(context, "/login");
                        // }
                      }

                      if (username == null ||
                          username == "" ||
                          password == "" ||
                          password == null ||
                          address == null ||
                          address == "" ||
                          phone == null ||
                          phone == "") {
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
                        signup();
                      }
                    },
                    icon: Icon(
                      FontAwesome5Solid.user_plus,
                      color: Colors.white,
                    ),
                    label: Text("Signup"),
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
