import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/pages/favorite_product_page.dart';
import 'package:highlandcoffeeapp/components/pages/search_result_product_page.dart';
import 'package:highlandcoffeeapp/components/widget/best_sale_product_item.dart';
import 'package:highlandcoffeeapp/components/widget/product_category.dart';
import 'package:highlandcoffeeapp/components/widget/choose_login_type_page%20.dart';
import 'package:highlandcoffeeapp/components/pages/coffee_page.dart';
import 'package:highlandcoffeeapp/components/pages/freeze_page.dart';
import 'package:highlandcoffeeapp/components/pages/list_product_page.dart';
import 'package:highlandcoffeeapp/components/pages/other_page.dart';
import 'package:highlandcoffeeapp/components/pages/product_popular_page.dart';
import 'package:highlandcoffeeapp/components/pages/sweet_cake_page.dart';
import 'package:highlandcoffeeapp/components/pages/tea_page.dart';
import 'package:highlandcoffeeapp/components/widget/product_popular_item.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/auth/auth_user_page.dart';
import 'package:highlandcoffeeapp/pages/cart/cart_page.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/pages/user/profile/profile_user_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/mic/mic_form.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';
import 'package:highlandcoffeeapp/util/product/product_category_form.dart';
import 'package:highlandcoffeeapp/components/widget/slide_image.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndexBottomBar = 0;
  bool _isListening = false;
  bool _isMicFormVisible = false;
  final _textSearchController = TextEditingController();
  List<DocumentSnapshot> searchResults = [];

  //
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  //SelectedBottomBar
  void _selectedBottomBar(int index) {
    if (index == 0) {
      // Check if the home icon is pressed
      _refreshData(); // Perform the refresh logic
    } else {
      setState(() {
        _selectedIndexBottomBar = index;
      });
    }
  }

  //
  Future<void> _refreshData() async {
    // Implement your refresh logic here
    // For example, you can fetch new data from the server
    // or reset the state of your widget

    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      // Update your data or perform any other necessary actions
    });
  }

  //
  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      // Yêu cầu quyền truy cập
      await Permission.microphone.request();
    }
  }

//
  void _startListening() async {
    await _requestMicrophonePermission();

    if (await Permission.microphone.isGranted) {
      // Quyền đã được cấp, bắt đầu lắng nghe
      // Sử dụng speech_to_text để thực hiện thu âm

      Get.to(() => MicForm())?.then((value) {
        // Xử lý sau khi người dùng đóng trang MicForm
        setState(() {
          _isMicFormVisible = false;
        });
      });
    } else {
      // Người dùng từ chối cấp quyền
      // Xử lý tương ứng, ví dụ hiển thị thông báo
      print("Người dùng từ chối cấp quyền truy cập vào microphone");
    }
  }

  //
  void performSearch(String query) {
    FirebaseFirestore.instance
        .collection('Danh sách sản phẩm')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<Products> searchResults = querySnapshot.docs
          .where((doc) => doc['name'] != null && doc['name'] is String)
          .map((doc) => Products(
              // Tạo đối tượng Products từ dữ liệu Firestore
              imagePath: doc['imagePath'],
              name: doc['name'],
              oldPrice: doc['oldPrice'],
              newPrice: doc['newPrice'],
              id: doc['id'],
              description: doc['description'],
              rating: doc['rating'],
              imageDetailPath: doc['imageDetailPath'],
              category: doc['category']))
          .toList();

      // Nếu không có kết quả, thử tìm kiếm theo tên không dấu và so sánh
      if (searchResults.isEmpty) {
        String normalizedQuery = removeDiacritics(query.toLowerCase());
        searchResults = querySnapshot.docs
            .where((doc) =>
                doc['normalized_name'] != null &&
                doc['normalized_name'] is String &&
                doc['normalized_name'].contains(normalizedQuery))
            .map((doc) => Products(
                // Tạo đối tượng Products từ dữ liệu Firestore
                imagePath: doc['imagePath'],
                name: doc['name'],
                oldPrice: doc['oldPrice'],
                newPrice: doc['newPrice'],
                id: doc['id'],
                description: doc['description'],
                rating: doc['rating'],
                imageDetailPath: doc['imageDetailPath'],
                category: doc['category']))
            .toList();
      }

      // In ra danh sách sản phẩm
      print('Search results: $searchResults');

      // Chuyển hướng đến trang hiển thị kết quả tìm kiếm
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultPage(searchResults: searchResults),
        ),
      );
    }).catchError((error) {
      print('Error searching products: $error');
    });
  }

// Hàm loại bỏ dấu tiếng Việt
  String removeDiacritics(String input) {
    return input
        .replaceAll('ă', 'a')
        .replaceAll('â', 'a')
        .replaceAll('đ', 'd')
        .replaceAll('ê', 'e')
        .replaceAll('ô', 'o')
        .replaceAll('ơ', 'o')
        .replaceAll('ư', 'u')
        .replaceAll('á', 'a')
        .replaceAll('à', 'a')
        .replaceAll('ả', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('ạ', 'a')
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('ẻ', 'e')
        .replaceAll('ẽ', 'e')
        .replaceAll('ẹ', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ì', 'i')
        .replaceAll('ỉ', 'i')
        .replaceAll('ĩ', 'i')
        .replaceAll('ị', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ò', 'o')
        .replaceAll('ỏ', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ọ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ù', 'u')
        .replaceAll('ủ', 'u')
        .replaceAll('ũ', 'u')
        .replaceAll('ụ', 'u')
        .replaceAll('ý', 'y')
        .replaceAll('ỳ', 'y')
        .replaceAll('ỷ', 'y')
        .replaceAll('ỹ', 'y')
        .replaceAll('ỵ', 'y');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColors,
        title: Container(
          height: 40,
          child: TextField(
            controller: _textSearchController,
            onSubmitted: (String query) {
              performSearch(query);
            },
            decoration: InputDecoration(
                hintText: 'Tìm kiếm đồ uống của bạn...',
                contentPadding: EdgeInsets.symmetric(),
                alignLabelWithHint: true,
                filled: true,
                fillColor: white,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                //icon search with microphone
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    size: 20,
                  ),
                  focusColor: primaryColors,
                  onPressed: _startListening,
                  // onPressed: () {
                  //   setState(() {
                  //     _isMicFormVisible = !_isMicFormVisible;
                  //   });
                  // },
                ),
                //icon clear
                // suffixIcon: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     width: 20,
                //     height: 20,
                //     decoration: BoxDecoration(
                //         color: background, shape: BoxShape.circle),
                //     child: Center(
                //       child: IconButton(
                //         icon: const Icon(
                //           Icons.clear,
                //           size: 10,
                //         ),
                //         onPressed: () {
                //           _textSearchController.clear();
                //         },100
                //       ),
                //     ),
                //   ),
                // ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white))),
          ),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //slide adv
              SlideImage(
                height: 180,
              ),
              SizedBox(height: 15),
              //product category
              ProductCategory(),
              SizedBox(height: 15),
              //product popular item
              ProductPopularItem(),
              SizedBox(
                height: 5.0,
              ),
              //more product popular
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/product_popular_page');
                    },
                    child: Text(
                      'Xem thêm >>',
                      style: GoogleFonts.arsenal(color: blue, fontSize: 17),
                    ),
                  ),
                ],
              ),
              // hot product
              Text('ĐỒ UỐNG HÓT',
                  style: GoogleFonts.arsenal(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColors)),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: BestSaleProductItem(),
              ),
            ],
          ),
        ),
      ),
      //bottom bar
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primaryColors,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndexBottomBar,
          onTap: _selectedBottomBar,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () {
                  // Điều hướng đến trang mới ở đây
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListProductPage(),
                    ),
                  );
                },
                child: Icon(Icons.local_dining),
              ),
              label: 'Sản phẩm',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteProductPage(),
                      ),
                    );
                  },
                  child: Icon(Icons.favorite)),
              label: 'Yêu thích',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: Icon(Icons.shopping_cart)),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileUserPage(),
                      ),
                    );
                  },
                  child: Icon(Icons.person)),
              label: 'Hồ sơ',
            ),
          ]),
    );
  }
}
