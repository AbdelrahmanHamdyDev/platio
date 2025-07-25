import 'package:flutter/material.dart';
import 'package:platio/View/splashScreen.dart';
import 'package:platio/View/loginScreen.dart';
import 'package:platio/View/listScreen.dart';
import 'package:platio/View/startScreen.dart';

enum Listtype { menu, cart }

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => splashScreen(),
        '/start': (context) => startScreen(),
        '/login': (context) => loginScreen(),
        '/menu': (context) => listScreen(type: Listtype.menu),
        '/cart': (context) => listScreen(type: Listtype.cart),
      },
    ),
  );
}
