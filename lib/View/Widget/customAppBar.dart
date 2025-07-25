import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class customAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            spacing: 10,
            children: [
              const Text(
                //TODO: get the total price of the cart
                "500 \$",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
