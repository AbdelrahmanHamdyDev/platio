import 'package:cloud_firestore/cloud_firestore.dart';

class menuItem_Model {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  menuItem_Model({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory menuItem_Model.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print("id: ${doc.id}");
    print("title: ${data['title']}");
    return menuItem_Model(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
    );
  }
}
