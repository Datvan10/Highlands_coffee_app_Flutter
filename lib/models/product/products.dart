class Products {
  String imagePath;
  String name;
  String oldPrice;
  String newPrice;
  String rating;

  Products(
      {required this.name,
      required this.imagePath,
      required this.oldPrice,
      required this.newPrice,
      required this.rating});

  String get _name => name;
  String get _oldPrice => oldPrice;
  String get _newPrice => newPrice;
  String get _imagePath => imagePath;
  String get _rating => rating;
}
