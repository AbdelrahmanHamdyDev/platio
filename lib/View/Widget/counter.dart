import 'package:flutter/material.dart';
import 'package:platio/main.dart';

class counter_Widget extends StatefulWidget {
  const counter_Widget({super.key, required this.type});

  final Listtype type;

  @override
  State<counter_Widget> createState() => _counter_WidgetState();
}

class _counter_WidgetState extends State<counter_Widget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> core = [
      //plus
      IconButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        icon: Icon(Icons.add),
      ),
      //icon
      Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Text(counter.toString()),
      ),
      //minus
      IconButton(
        onPressed: () {
          setState(() {
            counter--;
          });
        },
        icon: Icon(Icons.remove),
      ),
    ];
    return (widget.type == Listtype.cart)
        ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: core,
        )
        : Row(textDirection: TextDirection.rtl, children: core);
  }
}
