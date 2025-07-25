import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_auth/firebase_auth.dart';

class customAppBar extends StatelessWidget {
  final fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              fireAuth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                style: const TextStyle(fontSize: 20, color: Colors.black),
                children: [
                  const TextSpan(text: "Welcome Again "),
                  TextSpan(
                    text: fireAuth.currentUser?.displayName ?? "User",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          const Text(
            //TODO: get the total price of the cart
            "500 \$",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/cart'),
            child: badges.Badge(
              badgeAnimation: badges.BadgeAnimation.scale(),
              //TODO: Add the total items in the cart
              badgeContent: const Text("5"),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
