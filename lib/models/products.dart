import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String id;
  final String category;
  final String name;
  final String description;
  final double oldPrice;
  final double newPrice;
  final String rating;
  final String imagePath;
  final String imageDetailPath;

  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.oldPrice,
    required this.newPrice,
    required this.rating,
    required this.imagePath,
    required this.imageDetailPath, required this.category,
  });

  // Add a factory method to create a Products instance from a Firestore document
  factory Products.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Products(
      id: doc.id,
      category : data['category'],
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      oldPrice: (data['oldPrice'] as num?)?.toDouble() ?? 0.0,
      newPrice: (data['newPrice'] as num?)?.toDouble() ?? 0.0,
      rating: data['rating'] ?? '',
      imagePath: data['imagePath'] ?? '',
      imageDetailPath: data['imageDetailPath'] ?? '',
    );
  }
}
