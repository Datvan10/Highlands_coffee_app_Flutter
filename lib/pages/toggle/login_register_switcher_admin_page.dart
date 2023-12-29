import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/pages/login_sign/admin/login_admin_page.dart';
import 'package:highlandcoffeeapp/pages/login_sign/admin/register_admin_page.dart';

class LoginRegisterSwitcherAdminPage extends StatefulWidget {
  const LoginRegisterSwitcherAdminPage({Key? key}) : super(key: key);

  @override
  _LoginRegisterSwitcherPageAdminState createState() =>
      _LoginRegisterSwitcherPageAdminState();
}

class _LoginRegisterSwitcherPageAdminState extends State<LoginRegisterSwitcherAdminPage> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: showLoginPage
            ? LoginAdminPage(onTap: togglePage)
            : RegisterAdminPage(onTap: togglePage),
      ),
    );
  }
}
