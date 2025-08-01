import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platio/Controller/stateManagement.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:platio/main.dart';

class counter_Widget extends ConsumerWidget {
  const counter_Widget({super.key, required this.type, required this.item});

  final Listtype type;
  final menuItem_Model item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemQuantity = ref.watch(cartProvider)[item] ?? 0;

    List<Widget> core = [
      //plus
      IconButton(
        onPressed: () {
          ref.read(cartProvider.notifier).increaseQuantity(item);
        },
        icon: const Icon(Icons.add),
      ),
      //icon
      Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 2),
        ),
        child: Text(itemQuantity.toString(), style: GoogleFonts.gloock()),
      ),
      //minus
      IconButton(
        onPressed: () {
          ref.read(cartProvider.notifier).decreaseQuantity(item);
        },
        icon: const Icon(Icons.remove),
      ),
    ];
    return (type == Listtype.cart)
        ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: core,
        )
        : Row(textDirection: TextDirection.rtl, children: core);
  }
}
