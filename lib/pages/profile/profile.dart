import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map profile;
  @override
  Widget build(BuildContext context) {
    profile = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                    Text(
                      profile['username'],
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                    Text(
                      profile['address'],
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone No.",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                    Text(
                      profile['phone'].toString(),
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    )
                  ],
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
            )),
      ),
    );
  }
}
