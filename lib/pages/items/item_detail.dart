import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:Yumniastic/main.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({Key key}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  Map data;
  String token;

  bool loading = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    data = arguments['data'];
    setState(() {
      getToken() async {
        token = await tokenStorage.read(key: "token");
      }

      getToken();
    });

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            data['title'],
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
            : ListView(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Image.network(
                      data['image'],
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SpinKitThreeBounce(
                            color: Colors.deepPurple,
                            size: 30.0,
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Chip(
                              backgroundColor: Colors.deepPurple,
                              label: Text(
                                data['category'],
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                          Text(
                            data['title'],
                            style: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          )
                        ],
                      ),
                      Text(
                        "${data['price'].round()} Rs.",
                        style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      "Description",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: Text(
                      "${data['description']}",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });
              Response res = await put(
                  'https://yumniastic.herokuapp.com/api/add-to-cart/${data["id"]}/$token/');
              String response = json.decode(res.body)['res'];
              setState(() {
                loading = false;
              });
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(response,
                    style: TextStyle(
                        fontFamily: "Quicksand", fontWeight: FontWeight.bold)),
              ));
            },
            child: Icon(FontAwesome5Solid.cart_plus)));
  }
}
