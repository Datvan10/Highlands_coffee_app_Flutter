import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/pages/list_product_page.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/cart/cart_page.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/pages/home/home_page.dart';
import 'package:highlandcoffeeapp/pages/user/profile/profile_user_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';

class FavoriteProductPage extends StatefulWidget {
  const FavoriteProductPage({super.key});

  @override
  State<FavoriteProductPage> createState() => _FavoriteProductPageState();
}

class _FavoriteProductPageState extends State<FavoriteProductPage> {
  int _selectedIndexBottomBar = 2;
  late Stream<List<Products>> productsStream;
  void _selectedBottomBar(int index) {
    setState(() {
      _selectedIndexBottomBar = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set up the stream to listen for changes in the "Coffee" collection
    productsStream = FirebaseFirestore.instance
        .collection('Sản phẩm yêu thích')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Products.fromDocument(doc)).toList());
  }

  void _navigateToProductDetails(int index, List<Products> products) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(product: products[index]),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'SẢN PHẨM YÊU THÍCH',
          style: GoogleFonts.arsenal(
            color: primaryColors,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: primaryColors,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: primaryColors,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Products>>(
        stream: productsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Products> products = snapshot.data ?? [];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18.0,
                    mainAxisSpacing: 18.0,
                    childAspectRatio: 0.64,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) => ProductForm(
                    product: products[index],
                    onTap: () => _navigateToProductDetails(index, products),
                  ),
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primaryColors,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndexBottomBar,
          onTap: _selectedBottomBar,
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: (){
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Icon(Icons.home)),
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