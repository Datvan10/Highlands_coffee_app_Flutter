import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:highlandcoffeeapp/components/pages/bill_page.dart';
import 'package:highlandcoffeeapp/components/pages/bread_page.dart';
import 'package:highlandcoffeeapp/components/pages/sweet_cake_page.dart';
import 'package:highlandcoffeeapp/components/pages/coffee_page.dart';
import 'package:highlandcoffeeapp/components/pages/product_popular_page.dart';
import 'package:highlandcoffeeapp/components/pages/profile_page.dart';
import 'package:highlandcoffeeapp/components/pages/tea_page.dart';
import 'package:highlandcoffeeapp/firebase_options.dart';
import 'package:highlandcoffeeapp/pages/auth/auth_page.dart';
import 'package:highlandcoffeeapp/pages/cart/cart_page.dart';
import 'package:highlandcoffeeapp/pages/home/home_page.dart';
import 'package:highlandcoffeeapp/pages/introduce/introduce_page1.dart';
import 'package:highlandcoffeeapp/pages/introduce/introduce_page2.dart';
import 'package:highlandcoffeeapp/pages/login/login_page.dart';
import 'package:highlandcoffeeapp/pages/signinup/singinup_page.dart';
import 'package:highlandcoffeeapp/pages/welcome/welcome_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

void main()  => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.ios
//   // );
//   runApp(
//     const MyApp()
//     );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      home: const WelcomePage(),
      getPages: [
        GetPage(name: '/welcome_page', page: () => const WelcomePage()),
        GetPage(name: '/introduce_page1', page: () => const IntroducePage1()),
        GetPage(name: '/introduce_page2', page: () => const IntroducePage2()),
        GetPage(name: '/home_page', page: () => const HomePage()),
        GetPage(name: '/product_popular_page', page:() => const ProductPopularPage()),
        // GetPage(name: '/cart_page', page:() => CartPage(arguments: null,)),
      ],
      theme: ThemeData(
        primaryColor: primaryColors,
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

