import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(15),
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                icon: Icon(FontAwesome5Solid.sign_in_alt),
                label: Text("Login",
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                    ))),
            RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(15),
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
                icon: Icon(FontAwesome5Solid.user_plus),
                label: Text("Signup",
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w600,
                    )))
          ],
        ),
      ),
    );
  }
}
