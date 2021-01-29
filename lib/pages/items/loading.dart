import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoadingItems extends StatefulWidget {
  LoadingItems({Key key}) : super(key: key);

  @override
  _LoadingItemsState createState() => _LoadingItemsState();
}

class _LoadingItemsState extends State<LoadingItems> {
  Map input;
  void getItems() async {
    Response res = await get(
        "https://yumniastic.herokuapp.com/api/items/${input['data']['id']}/");
    List data = jsonDecode(res.body);
    Map args = {"data": data, "category": input['data']};
    Navigator.pushReplacementNamed(context, "/items", arguments: args);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    input = ModalRoute.of(context).settings.arguments;
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
