class Users {
  final String? id;
  final String? email;
  final int? phoneNumber;
  final String? address;
  final String? userName;
  final String? passWord;

  Users({
    this.id,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.userName,
    required this.passWord,
  });

  toJson(){
    return{
      "Email" : email,
      "Phonenumber" : phoneNumber,
      "Address" : address,
      "Username" : userName,
      "Password" : passWord
    };
  }
}