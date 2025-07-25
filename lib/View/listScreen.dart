import 'package:flutter/material.dart';
import 'package:platio/Controller/firebase.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:platio/View/Widget/customAppBar.dart';
import 'package:platio/View/Widget/cart_item.dart';
import 'package:platio/View/Widget/menu_item.dart';
import 'package:platio/main.dart';

class listScreen extends StatelessWidget {
  const listScreen({super.key, required this.type});

  final Listtype type;

  @override
  Widget build(BuildContext context) {
    List<menuItem_Model> dummyMenuItems = [
      menuItem_Model(
        id: "item1",
        title: "Chocolate Lava Cake",
        description:
            "Warm chocolate cake with a gooey molten center, served with vanilla ice cream.",
        imageUrl:
            "https://www.foodandwine.com/thmb/XdFd-DvTtouryLCjeCqwhfmmK-A=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/molten-chocolate-cake-FT-RECIPE0220-0a33d7d0ab0c45588f7bfe742d33a9bc.jpg",
        price: 5.25,
      ),
      menuItem_Model(
        id: "item2",
        title: "Classic Cheeseburger",
        description:
            "Juicy beef patty with melted cheddar, lettuce, tomato, and special sauce on a toasted bun.",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIhD3VIrl1qK5TCm5A2sKgq5dVyjL2ORWW_Q&s",
        price: 8.99,
      ),
    ];
    final FireStore fireStore = FireStore();
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future:
              (type == Listtype.menu)
                  ? fireStore.getMenuItems()
                  : Future.value(dummyMenuItems),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final items = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height / 10,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        (type == Listtype.menu) ? customAppBar() : AppBar(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child:
                          (type == Listtype.menu)
                              ? menuItem_Widget(item: items[index])
                              : cartItem_Widget(item: items[index]),
                    );
                  }, childCount: items.length),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
