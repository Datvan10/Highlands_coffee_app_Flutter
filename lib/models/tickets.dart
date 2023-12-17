class Tickets {
  String imagePath;
  String name;
  String description;
  String date;
  String titleUse;

  Tickets(
      {required this.imagePath,
      required this.name,
      required this.description,
      required this.date,
      required this.titleUse,
});

  String get _imagePath => imagePath;
  String get _name => name;
  String get _description => description;
  String get _date => date;
  String get _titleUse => titleUse;
}
