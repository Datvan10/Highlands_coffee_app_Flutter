// ignore_for_file: public_member_api_docs, sort_constructors_first
class Orders {
  String id;
  String productName;
  double totalPrice;
  int quantity;
  String size;

  Orders({
    required this.id,
    required this.productName,
    required this.totalPrice,
    required this.quantity,
    required this.size,
  });
}
