import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platio/View/Screen/splashScreen.dart';
import 'package:platio/View/Screen/loginScreen.dart';
import 'package:platio/View/Screen/listScreen.dart';
import 'package:platio/View/Screen/startScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

enum Listtype { menu, cart }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(color: Colors.white),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => splashScreen(),
          '/start': (context) => const startScreen(),
          '/login': (context) => const loginScreen(),
          '/menu': (context) => const listScreen(type: Listtype.menu),
          '/cart': (context) => const listScreen(type: Listtype.cart),
        },
      ),
    ),
  );
}
