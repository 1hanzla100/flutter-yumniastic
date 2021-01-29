import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Yumniastic/main.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<dynamic> data;
  List<dynamic> popularItems;

  int categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    data = arguments['data'];
    popularItems = arguments['popularItems'];

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
            "Yumniastic",
            style: TextStyle(
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
                fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        'Yumniastic',
                        style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25),
                      ),
                    )),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
              ),
              ListTile(
                title: Text(
                  'Cart',
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/loading_cart");
                },
              ),
              ListTile(
                title: Text(
                  'My Orders',
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/loading_orders");
                },
              ),
              ListTile(
                title: Text(
                  'My Profile',
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/loading_profile");
                },
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                onTap: () async {
                  await tokenStorage.deleteAll();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, "/auth_home");
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
            Navigator.pushReplacementNamed(context, '/loading_home');
            return null;
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  )),
              SizedBox(
                height: 75, // card height
                child: PageView.builder(
                  itemCount: data.length,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) =>
                      setState(() => categoryIndex = index),
                  itemBuilder: (context, index) {
                    return Transform.scale(
                        scale: index == categoryIndex ? 1 : 0.9,
                        child: Card(
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/loading_items',
                                    arguments: {
                                      "data": data[index],
                                    });
                              },
                              child: Column(children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            data[index]['name'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Quicksand"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ]),
                            )));
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Popular Products",
                    style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  )),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    children: popularItems
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
                                        if (loadingProgress == null)
                                          return child;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
            ]),
          ),
        ));
  }
}
