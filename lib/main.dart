import 'package:flutter/material.dart';

import 'package:Yumniastic/pages/items/items.dart';
import 'package:Yumniastic/pages/items/loading.dart';
import 'package:Yumniastic/pages/items/item_detail.dart';

import 'package:Yumniastic/pages/cart/loading.dart';
import 'package:Yumniastic/pages/cart/cart.dart';

import 'package:Yumniastic/pages/auth/signup.dart';
import 'package:Yumniastic/pages/auth/login.dart';
import 'package:Yumniastic/pages/auth/main.dart';

import 'package:Yumniastic/pages/checkout/checkout.dart';

import 'package:Yumniastic/pages/orders/loading.dart';
import 'package:Yumniastic/pages/orders/orders.dart';
import 'package:Yumniastic/pages/orders/order_detail.dart';

import 'package:Yumniastic/pages/home/home.dart';
import 'package:Yumniastic/pages/home/loading.dart';

import 'package:Yumniastic/pages/profile/loading.dart';
import 'package:Yumniastic/pages/profile/profile.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage tokenStorage = new FlutterSecureStorage();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yumniastic',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/auth_home',
      routes: {
        '/loading_items': (context) => LoadingItems(),
        '/items': (context) => Items(),
        '/item_detail': (context) => ItemDetail(),
        '/loading_cart': (context) => LoadingCart(),
        '/cart': (context) => Cart(),
        '/auth_home': (context) => AuthHome(),
        '/signup': (context) => Signup(),
        '/login': (context) => Login(),
        '/checkout': (context) => Checkout(),
        '/loading_orders': (context) => LoadingOrders(),
        '/orders': (context) => Orders(),
        '/order_detail': (context) => OrderDetail(),
        '/loading_home': (context) => CategoryLoading(),
        '/home': (context) => Category(),
        '/loading_profile': (context) => LoadingProfile(),
        '/profile': (context) => Profile()
      },
    );
  }
}
