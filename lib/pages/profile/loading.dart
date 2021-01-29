import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:Yumniastic/main.dart';

class LoadingProfile extends StatefulWidget {
  LoadingProfile({Key key}) : super(key: key);

  @override
  _LoadingProfileState createState() => _LoadingProfileState();
}

class _LoadingProfileState extends State<LoadingProfile> {
  void getProfile() async {
    String token = await tokenStorage.read(key: "token");
    Response res =
        await get("https://yumniastic.herokuapp.com/api/profile/$token/");
    Map data = jsonDecode(res.body);
    Navigator.pushReplacementNamed(context, "/profile", arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    getProfile();
    return Scaffold(
        body: Center(
      child: SpinKitThreeBounce(
        color: Colors.deepPurple,
        size: 50.0,
      ),
    ));
  }
}
