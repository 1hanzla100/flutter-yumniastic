import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PendingOrders extends StatefulWidget {
  final List data;
  PendingOrders({Key key, this.data}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/order_detail',
                      arguments: widget.data[index]);
                },
                child: ListTile(
                  title: Text(
                    DateFormat("d MMMM y").format(
                        DateTime.parse(widget.data[index]['ordered_date'])),
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    "Total Price: ${widget.data[index]['total_price'].round()}",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
