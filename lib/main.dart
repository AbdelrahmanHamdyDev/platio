import 'package:flutter/material.dart';
import 'package:platio/View/splashScreen.dart';
import 'package:platio/View/loginScreen.dart';
import 'package:platio/View/listScreen.dart';
import 'package:platio/View/startScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

enum Listtype { menu, cart }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
