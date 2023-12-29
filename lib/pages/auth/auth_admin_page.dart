import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/pages/admin/admin_page.dart';
import 'package:highlandcoffeeapp/pages/toggle/login_register_switcher_admin_page.dart';

class AuthAdminPage extends StatelessWidget {
  const AuthAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AdminPage();
          } else {
            return LoginRegisterSwitcherAdminPage();
          }
        },
      ),
    );
  }
}
