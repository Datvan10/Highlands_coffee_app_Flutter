import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/users.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class InformationForm extends StatelessWidget {
  final String userId; // Thêm thuộc tính userId
  const InformationForm({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> getUserData(String userId) async {
      try {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .get();

        if (userSnapshot.exists) {
          return userSnapshot.data() ?? {};
        } else {
          return {};
        }
      } catch (e) {
        print('Error fetching user data: $e');
        return {};
      }
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Lấy thông tin từ snapshot.data
          dynamic userData = snapshot.data;
          String userName = userData?['userName'].toString() ?? '';
          String address = userData?['address'].toString() ?? '';
          String phoneNumber = userData?['phoneNumber'].toString() ?? '';

          return Container(
            height: 150,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: primaryColors),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        userName,
                        style: GoogleFonts.arsenal(
                          fontSize: 18,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColors),
                      SizedBox(
                        width: 10,
                      ),
                      Text(address,
                          style: GoogleFonts.arsenal(
                            fontSize: 18,
                            color: black,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, color: primaryColors),
                      SizedBox(
                        width: 10,
                      ),
                      Text('+84 ' + phoneNumber,
                          style: GoogleFonts.arsenal(
                            fontSize: 18,
                            color: black,
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
