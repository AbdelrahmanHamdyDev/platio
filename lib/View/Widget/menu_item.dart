import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platio/Controller/stateManagement.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:platio/View/Widget/counter.dart';
import 'package:platio/main.dart';

class menuItem_Widget extends ConsumerWidget {
  const menuItem_Widget({super.key, required this.item});

  final menuItem_Model item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemQuantity = ref.watch(cartProvider)[item] ?? 0;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //image
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 2.5,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.network(item.imageUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 10),
          //title
          Text(
            item.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ),

          SizedBox(height: 10),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //price
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.shade300,
                ),
                child: Text(
                  "\$ ${item.price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(width: 2, height: 50, color: Colors.black),
              //cart
              if (itemQuantity == 0)
                IconButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).toggleItem(item);
                  },
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
              if (itemQuantity != 0)
                counter_Widget(item: item, type: Listtype.menu),
            ],
          ),
          Divider(height: 1, color: Colors.black, thickness: 2),
        ],
      ),
    );
  }
}
