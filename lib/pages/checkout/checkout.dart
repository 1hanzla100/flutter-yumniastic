import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  Checkout({Key key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Map data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Checkout",
            style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
                fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Order ID",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    data['token'],
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Delivery Address",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    data['address'],
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Conatct No.",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    data['phone'].toString(),
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Text(
                "Amount ${data['price'].round()} Rs.",
                style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              RaisedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(10),
                  icon: Icon(Icons.keyboard_return, color: Colors.white),
                  label: Text("Return to Home",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  color: Colors.deepPurple)
            ],
          ),
        ));
  }
}
