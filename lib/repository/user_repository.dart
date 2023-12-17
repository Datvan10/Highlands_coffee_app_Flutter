import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:highlandcoffeeapp/models/users.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(Users user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(() => Get.snackbar('Success', 'message'));
  }
}
