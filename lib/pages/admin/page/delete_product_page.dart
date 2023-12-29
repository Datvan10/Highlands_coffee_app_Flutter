import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/widget/my_button.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class DeleteProductPage extends StatefulWidget {
  static const String routeName = '/delete_product_page';
  const DeleteProductPage({Key? key}) : super(key: key);

  @override
  State<DeleteProductPage> createState() => _DeleteProductPageState();
}

class _DeleteProductPageState extends State<DeleteProductPage> {
  final _textSearchProductController = TextEditingController();
  Future<List<Products>> getProductsFromCollection(
      String collectionName) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Products(
          id: data['id'],
          name: data['name'],
          description: data['description'],
          imagePath: data['imagePath'],
          imageDetailPath: data['imageDetailPath'],
          oldPrice: data['oldPrice'].toDouble(),
          newPrice: data['newPrice'].toDouble(),
          rating: data['rating'], category: '',
        );
      }).toList();
    } catch (e) {
      print('Error getting products from $collectionName: $e');
      return [];
    }
  }

  Future<List<Products>> getAllProducts() async {
    List<String> collectionNames = [
      'Bánh mì',
      'Bánh ngọt',
      'Coffee',
      'Danh sách sản phẩm',
      'Danh sách sản phẩm phổ biến',
      'Freeze',
      'Sản phẩm bán chạy nhất',
      'Sản phẩm phổ biến',
      'Trà',
    ];

    List<Future<List<Products>>> futures = [];
    for (String collectionName in collectionNames) {
      futures.add(getProductsFromCollection(collectionName));
    }

    List<List<Products>> results = await Future.wait(futures);
    List<Products> allProducts = results.expand((list) => list).toList();

    return allProducts;
  }

  List<Products> productList = [];
  // Hàm để xóa sản phẩm từ danh sách
  void deleteProduct(int index) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "Thông báo",
            style: GoogleFonts.arsenal(
                color: primaryColors,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          content: Text("Bạn có chắc muốn xóa sản phẩm này?"),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text("Xóa"),
              onPressed: () {
                // Thực hiện xóa sản phẩm và đóng hộp thoại
                setState(() {
                  productList.removeAt(index);
                });
                Navigator.pop(context); // Đóng hộp thoại
              },
            ),
            CupertinoDialogAction(
              child: Text(
                "Hủy",
                style: TextStyle(color: blue),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    productList = await getAllProducts();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 18.0, top: 18.0, right: 18.0, bottom: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Xóa sản phẩm',
                    style: GoogleFonts.arsenal(
                      fontSize: 30,
                      color: brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _textSearchProductController,
                  decoration: InputDecoration(
                      hintText: 'Tìm kiếm sản phẩm',
                      contentPadding: EdgeInsets.symmetric(),
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: white,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                      ),
                      //icon clear
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: background, shape: BoxShape.circle),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.clear,
                                size: 10,
                              ),
                              onPressed: () {
                                _textSearchProductController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Danh sách sản phẩm',
                    style: GoogleFonts.arsenal(
                      fontSize: 20,
                      color: brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // Hiển thị danh sách sản phẩm
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 25.0),
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.network(
                          productList[index].imagePath,
                          height: 80,
                          width: 80,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productList[index].name,
                              style: GoogleFonts.arsenal(
                                  fontSize: 18,
                                  color: primaryColors,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              productList[index].newPrice.toStringAsFixed(3) +
                                  'đ',
                              style: GoogleFonts.roboto(
                                color: primaryColors,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 19,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 19,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 19,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 19,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: red,
                          ),
                          onPressed: () {
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        //
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
          child: MyButton(
            text: 'Hoàn thành',
            onTap: () {},
            buttonColor: primaryColors,
          ),
        )
      ],
    );
  }
}
