import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:Yumniastic/main.dart';

class LoadingCart extends StatefulWidget {
  LoadingCart({Key key}) : super(key: key);

  @override
  _LoadingCartState createState() => _LoadingCartState();
}

class _LoadingCartState extends State<LoadingCart> {
  void getItems() async {
    String token = await tokenStorage.read(key: "token");
    Response res =
        await get("https://yumniastic.herokuapp.com/api/order-summary/$token/");
    Map data = jsonDecode(res.body);
    Map args = {
      "data": data,
    };
    Navigator.pushReplacementNamed(context, "/cart", arguments: args);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getItems();
    return Scaffold(
        body: Center(
      child: SpinKitThreeBounce(
        color: Colors.deepPurple,
        size: 50.0,
      ),
    ));
  }
}
