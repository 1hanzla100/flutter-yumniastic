import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';

class CategoryLoading extends StatefulWidget {
  CategoryLoading({Key key}) : super(key: key);

  @override
  _CategoryLoadingState createState() => _CategoryLoadingState();
}

class _CategoryLoadingState extends State<CategoryLoading> {
  void getItems() async {
    Response res =
        await get("https://yumniastic.herokuapp.com/api/categories/");
    List<dynamic> data = jsonDecode(res.body);
    Response resPopularItems =
        await get("https://yumniastic.herokuapp.com/api/popular-items/");
    List<dynamic> popularItems = jsonDecode(resPopularItems.body);
    Map args = {"data": data, "popularItems": popularItems};
    Navigator.pushReplacementNamed(context, "/home", arguments: args);
  }

  @override
  void initState() {
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitThreeBounce(
        color: Colors.deepPurple,
        size: 50.0,
      ),
    ));
  }
}
