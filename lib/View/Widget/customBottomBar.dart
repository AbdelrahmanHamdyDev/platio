import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:google_fonts/google_fonts.dart';

class customBottomBar extends StatelessWidget {
  const customBottomBar({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.grey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        spacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price: ",
                style: GoogleFonts.playfairDisplay(fontSize: 20),
              ),
              AnimatedFlipCounter(
                textStyle: GoogleFonts.prata(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                duration: const Duration(milliseconds: 500),
                fractionDigits: 2,
                value: totalPrice,
                suffix: " \$",
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "The Order Confirmed\nThank you for using the app",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF25700),
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}
