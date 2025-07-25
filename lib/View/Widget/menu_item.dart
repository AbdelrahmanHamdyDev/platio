import 'package:flutter/material.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:badges/badges.dart' as badges;
import 'package:platio/View/Widget/counter.dart';
import 'package:platio/main.dart';

class menuItem_Widget extends StatefulWidget {
  const menuItem_Widget({super.key, required this.item});

  final menuItem_Model item;

  @override
  State<menuItem_Widget> createState() => _menuItem_WidgetState();
}

class _menuItem_WidgetState extends State<menuItem_Widget> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //image
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.network(widget.item.imageUrl),
            ),
          ),
          SizedBox(height: 10),
          //title
          Text(
            widget.item.title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(
              widget.item.description,
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
                  "\$ ${widget.item.price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(width: 2, height: 50, color: Colors.black),
              //cart
              if (counter == 0)
                IconButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
              if (counter != 0) counter_Widget(type: Listtype.menu),
            ],
          ),
          Divider(height: 1, color: Colors.black, thickness: 2),
        ],
      ),
    );
  }
}
