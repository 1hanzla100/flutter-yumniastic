import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Items extends StatefulWidget {
  Items({Key key}) : super(key: key);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List data;
  Map category;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    data = arguments['data'];
    category = arguments['category'];

    return Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/loading_cart");
                },
                icon:
                    Icon(FontAwesome5Solid.shopping_cart, color: Colors.white),
                label: Text(""))
          ],
          title: Text(
            category['name'],
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
            Navigator.pushReplacementNamed(context, '/loading_items',
                arguments: {"data": category});
            return null;
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GridView.count(
                crossAxisCount: 2,
                children: data
                    .map((item) => (Card(
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/item_detail',
                                arguments: {"data": item});
                          },
                          child: Wrap(children: [
                            Column(children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  item['image'],
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SpinKitThreeBounce(
                                        color: Colors.deepPurple,
                                        size: 20.0,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                // margin: EdgeInsets.symmetric(vertical: 15),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      item['title'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Quicksand"),
                                    ),
                                    Text("${item['price'].round()} Rs.",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ])
                          ]),
                        ))))
                    .toList()),
          ),

          // ),
        ));
  }
}
