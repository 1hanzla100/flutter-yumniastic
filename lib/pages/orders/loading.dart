import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:Yumniastic/main.dart';

class LoadingOrders extends StatefulWidget {
  LoadingOrders({Key key}) : super(key: key);

  @override
  _LoadingOrdersState createState() => _LoadingOrdersState();
}

class _LoadingOrdersState extends State<LoadingOrders> {
  void getOrders() async {
    String token = await tokenStorage.read(key: "token");
    Response res =
        await get("https://yumniastic.herokuapp.com/api/user-orders/$token/");
    Map data = jsonDecode(res.body);
    Map args = {
      "data": data,
    };
    Navigator.pushReplacementNamed(context, "/orders", arguments: args);
    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: Colors.deepPurple,
          size: 50.0,
        ),
      ),
    );
  }
}
