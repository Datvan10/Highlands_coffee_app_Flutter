class Products {
  String imagePath;
  String imageDetailPath;
  String name;
  String description;
  double oldPrice;
  double newPrice;
  String rating;

  Products(
      {required this.name,
      required this.description,
      required this.imagePath,
      required this.imageDetailPath,
      required this.oldPrice,
      required this.newPrice,
      required this.rating});

  String get _name => name;
  double get _oldPrice => oldPrice;
  double get _newPrice => newPrice;
  String get _imagePath => imagePath;
  String get _imageDetailPath => imageDetailPath;
  String get _rating => rating;
}
