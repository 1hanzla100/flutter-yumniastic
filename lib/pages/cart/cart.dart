import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:Yumniastic/main.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map data;
  String token;
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
          "Cart ",
          style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          Navigator.pushReplacementNamed(context, '/loading_cart');
          return null;
        },
        child: data['res'] != null
            ? Center(
                child: Text(data['res'],
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 25)),
              )
            : Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25),
                            ),
                            Text(
                              "${data['total_price'].round()} Rs.",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25),
                            ),
                          ]),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data['items'].length,
                          itemBuilder: (context, index) {
                            return Card(
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        data['items'][index]['title'],
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                      Chip(
                                        padding: EdgeInsets.all(5),
                                        backgroundColor: Colors.deepPurple,
                                        label: Text(
                                          data['items'][index]['quantity']
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: "Quicksand",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        "${data['items'][index]['items_price']} Rs.",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await put(
                                                "https://yumniastic.herokuapp.com/api/add-to-cart/${data['items'][index]['id']}/$token/");
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, "/loading_cart");
                                          },
                                          icon: Icon(Icons.add)),
                                      IconButton(
                                          onPressed: () async {
                                            await put(
                                                "https://yumniastic.herokuapp.com/api/remove-single-item-from-cart/${data['items'][index]['id']}/$token/");
                                            // setState(() {
                                            //   loading = false;
                                            // });
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, "/loading_cart");
                                          },
                                          icon: Icon(Icons.remove)),
                                      IconButton(
                                          onPressed: () async {
                                            await put(
                                                "https://yumniastic.herokuapp.com/api/remove-from-cart/${data['items'][index]['id']}/$token/");
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, "/loading_cart");
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    data['items'].length > 0
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: RaisedButton.icon(
                              onPressed: () async {
                                Response res = await get(
                                    "https://yumniastic.herokuapp.com/api/checkout/$token/");
                                Map resData = json.decode(res.body);
                                if (resData['res'] == null) {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/checkout',
                                      arguments: resData);
                                }
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Checkout",
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: Colors.green,
                            ),
                          )
                        : Text("No Item in Cart",
                            style: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w600,
                                fontSize: 15))
                  ],
                )),
      ),
    );
  }
}
