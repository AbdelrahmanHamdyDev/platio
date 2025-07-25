import 'package:flutter/material.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:platio/View/Widget/counter.dart';
import 'package:platio/main.dart';

class cartItem_Widget extends StatefulWidget {
  const cartItem_Widget({super.key, required this.item});

  final menuItem_Model item;

  @override
  State<cartItem_Widget> createState() => _cartItem_WidgetState();
}

class _cartItem_WidgetState extends State<cartItem_Widget> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text(
                    widget.item.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "\$ ${widget.item.price.toStringAsFixed(2)} / piece",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade300,
                    ),
                    child: Text(
                      "\$ ${(widget.item.price * counter).toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),

            //image
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 4,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.network(widget.item.imageUrl, fit: BoxFit.cover),
              ),
            ),
            counter_Widget(type: Listtype.cart),
          ],
        ),
      ),
    );
  }
}
