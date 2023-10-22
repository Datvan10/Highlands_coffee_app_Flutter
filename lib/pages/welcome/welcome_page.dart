import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlandcoffeeapp/pages/introduce/introduce_page1.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    var d = Duration(seconds: 5);
    Future.delayed(d, () {
      Get.offAll(() => IntroducePage1());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      body: Center(
          child: Image.asset('assets/images/welcome/highlands-coffee.jpg')),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     SizedBox(height: 50,),
      //     Image.asset('assets/images/welcome/highlands-coffee.jpg'),
      //     ButtonGetStarted(text: 'Get Started', onTap: (){})
      //   ],
      // )
    );
  }
}
