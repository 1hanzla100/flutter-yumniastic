import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({Key key}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Map data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            DateFormat("d MMMM y").format(DateTime.parse(data['ordered_date'])),
            style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
                fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Order ID:",
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Text(
                  data['ref_code'],
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Total Price:",
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Text(
                  "${data['total_price'].round()} Rs.".toString(),
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Being Delivered",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  data['being_delivered']
                      ? Icon(
                          Icons.done,
                          color: Colors.deepPurple,
                        )
                      : Icon(
                          Icons.cancel,
                          color: Colors.deepPurple,
                        )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Received",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  data['received']
                      ? Icon(
                          Icons.done,
                          color: Colors.deepPurple,
                        )
                      : Icon(
                          Icons.cancel,
                          color: Colors.deepPurple,
                        )
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(1),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              data['items'][index]['title'],
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              "Quantity: ${data['items'][index]['quantity']}",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            trailing: Text(
                              "Rs. ${data['items'][index]['items_price'].round()}",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ));
                  },
                  itemCount: data['items'].length,
                ),
              )
            ],
          ),
        ));
  }
}
