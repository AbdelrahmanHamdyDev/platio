import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platio/Controller/stateManagement.dart';

class customAppBar extends ConsumerWidget {
  final fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    final totalItemsQuantity = cart.values.fold(
      0,
      (sum, qty) => sum + qty,
    ); // sum all quantities
    final totalPrice = cart.entries.fold(
      0.0,
      (sum, entry) => sum + (entry.key.price * entry.value),
    );

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
          Text(
            "${totalPrice.round()} \$",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/cart'),
            child: badges.Badge(
              badgeAnimation: badges.BadgeAnimation.scale(),
              badgeContent: Text(totalItemsQuantity.toString()),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
