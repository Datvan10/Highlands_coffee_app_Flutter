import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:highlandcoffeeapp/models/products.dart';

class ProductService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Products');

  Future<List<Products>> getProducts() async {
    QuerySnapshot<Object?> snapshot =
        await productsCollection.get();

    return snapshot.docs.map((doc) {
      return Products(
        id: doc.id,
        name: doc['name'],
        description: doc['description'],
        imagePath: doc['imagePath'],
        imageDetailPath: doc['imageDetailPath'],
        oldPrice: doc['oldPrice'],
        newPrice: doc['newPrice'],
        rating: doc['rating'], category: '',
      );
    }).toList();
  }
}
