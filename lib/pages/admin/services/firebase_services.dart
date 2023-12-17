import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{
  Future<DocumentSnapshot<Map<String, dynamic>>>getAdminCredentials(id){
    var result = FirebaseFirestore.instance.collection('Admins').doc(id).get();
    return result;
  }
}