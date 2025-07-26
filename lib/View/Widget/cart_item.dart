import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:platio/View/Widget/counter.dart';
import 'package:platio/main.dart';

class cartItem_Widget extends StatelessWidget {
  const cartItem_Widget({
    super.key,
    required this.item,
    required this.quantity,
  });

  final menuItem_Model item;
  final int quantity;

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
                    item.title,
                    style: GoogleFonts.cinzel(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${item.price.toStringAsFixed(2)} ",
                        style: GoogleFonts.tenorSans(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "/ piece",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14, // smaller
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0XFF64baaa),
                    ),
                    child: Text(
                      "\$ ${(item.price * quantity).toStringAsFixed(2)}",
                      style: GoogleFonts.prata(fontSize: 15),
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
                child: Image.network(item.imageUrl, fit: BoxFit.cover),
              ),
            ),
            counter_Widget(item: item, type: Listtype.cart),
          ],
        ),
      ),
    );
  }
}
