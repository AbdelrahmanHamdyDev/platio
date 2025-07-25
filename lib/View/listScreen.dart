import 'package:flutter/material.dart';
import 'package:platio/Model/menuItem.dart';
import 'package:platio/View/Widget/customAppBar.dart';
import 'package:platio/View/Widget/cart_item.dart';
import 'package:platio/View/Widget/menu_item.dart';
import 'package:platio/main.dart';

List<menuItem_Model> dummyData = [
  menuItem_Model(
    id: "1",
    description: "Bun,burger meat, lectus, tomato, and special souse",
    title: "Burger",
    price: 20.99,
    imageUrl:
        "https://media.istockphoto.com/id/520410807/photo/cheeseburger.jpg?s=612x612&w=0&k=20&c=fG_OrCzR5HkJGI8RXBk76NwxxTasMb1qpTVlEM0oyg4=",
  ),
  menuItem_Model(
    id: "2",
    title: "Stick",
    description: "Stick meat, bbq sause",
    price: 80.9999,
    imageUrl:
        "https://www.seriouseats.com/thmb/-KA2hwMofR2okTRndfsKtapFG4Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__recipes__images__2015__05__Anova-Steak-Guide-Sous-Vide-Photos15-beauty-159b7038c56a4e7685b57f478ca3e4c8.jpg",
  ),
];

class listScreen extends StatelessWidget {
  const listScreen({super.key, required this.type});

  final Listtype type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (type == Listtype.menu) ? customAppBar() : AppBar(),
      //TODO: get the real data from the fireStore
      body: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder:
            (context, index) => Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child:
                  (type == Listtype.menu)
                      ? menuItem_Widget(item: dummyData[index])
                      : cartItem_Widget(item: dummyData[index]),
            ),
      ),
    );
  }
}
