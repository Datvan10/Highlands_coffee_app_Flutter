class Order {
  final String userName;
  final String phoneNumber;
  final String address;
  final String paymentMethod;
  final List<Map<String, dynamic>> products;
  final int totalQuantity;
  final double totalPrice;

  Order({
    required this.userName,
    required this.phoneNumber,
    required this.address,
    required this.paymentMethod,
    required this.products,
    required this.totalQuantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'address': address,
      'paymentMethod': paymentMethod,
      'products': products,
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
    };
  }
}
