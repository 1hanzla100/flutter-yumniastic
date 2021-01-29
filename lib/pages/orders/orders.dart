import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:Yumniastic/pages/orders/tabPages/pending.dart';
import 'package:Yumniastic/pages/orders/tabPages/completed.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Map data;
  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    data = arguments['data'];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "My Orders",
              style: TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(FontAwesome5Solid.clock),
                  text: "Pending",
                ),
                Tab(
                  icon: Icon(FontAwesome5Solid.check),
                  text: "Recieved",
                ),
              ],
            ),
          ),
          body: data['res'] != null
              ? Center(
                  child: Text(
                    data['res'],
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                )
              : TabBarView(
                  children: [
                    PendingOrders(data: data['pending_orders']),
                    Completedorders(data: data['completed_orders']),
                  ],
                )),
    );
  }
}
