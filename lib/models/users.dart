class Users {
  String firstName;
  String lastName;
  int age;
  String sex;
  String adress;
  int phoneNumber;
  String imagePath;

  Users({required this.firstName, required this.lastName, required this.age, required this.sex, required this.adress, required this.phoneNumber, required this.imagePath});

  String get _firstName => firstName;
  String get _lastName => lastName;
  int get _age => age;
  String get _sex => sex;
  String get _adress => adress;
  int get _phoneNumber => phoneNumber;
  String get _imagePath => imagePath;
}