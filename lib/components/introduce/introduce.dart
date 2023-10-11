class Introduce{
  String hello;
  String imagePath;
  String title;
  String description;

  Introduce({required this.hello, required this.imagePath, required this.title, required this.description});

  String get _hello => hello;
  String get _imagePath => imagePath;
  String get _title => title;
  String get _description => description;
}