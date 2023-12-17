import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_add_to_cart.dart';
import 'package:highlandcoffeeapp/components/button/button_buy_now.dart';
import 'package:highlandcoffeeapp/models/products.dart';
import 'package:highlandcoffeeapp/pages/cart/cart_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/size_product.dart';

class ProductDetailPage extends StatefulWidget {
  final Products product;
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class CartPageArguments {
  final List<CartItem> cartItems;

  CartPageArguments(this.cartItems);
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantityCount = 1; //quantity
  double totalPrice = 0.0; // total price
  bool isFavorite = false;
  String selectedSize = 'S';
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    updateTotalPrice();
  }

  //
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 1) {
        quantityCount--;
        updateTotalPrice();
      }
    });
  }

  //
  void incrementQuantity() {
    setState(() {
      quantityCount++;
      updateTotalPrice();
    });
  }

  // // initialization variable total price
  // double totalPrice = 0.0;

  void updateTotalPrice() {
    setState(() {
      double productPrice = widget.product.newPrice;
      totalPrice = productPrice * quantityCount;
    });
  }

  //
// Trong _ProductDetailPageState
  void addToCart(String productImage, String productName, double newPrice,
      double totalPrice, int quantity, String selectedSize) {
    // print('Adding to Cart: $productImage, $productName, $totalPrice, $quantity, $selectedSize');

    // Tạo một đối tượng CartItem
    CartItem item = CartItem(productImage, productName, newPrice, totalPrice,
        quantity, selectedSize);

    // Thêm mục vào giỏ hàng
    setState(() {
      cartItems.add(item);
    });

    // Gửi thông tin đến trang CartPage với danh sách cartItems đã cập nhật
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CartPage(arguments: CartPageArguments(cartItems)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                widget.product.imageDetailPath,
                fit: BoxFit.cover,
              ),
              //
              Positioned(
                top: 54,
                left: 8,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: white,
                  ),
                  onPressed: () {
                    // Xử lý khi nhấn nút quay lại
                    Navigator.of(context).pop();
                  },
                ),
              ),
              //
              Positioned(
                top: 54,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: white,
                  ),
                  onPressed: () {
                    // // Xử lý khi nhấn nút giỏ hàng
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => CartPage(),
                    // ));
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(color: white),
            child: Column(
              children: [
                //product name and icon favorite
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    widget.product.name,
                    style: GoogleFonts.arsenal(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: primaryColors),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: primaryColors,
                        size: 30,
                      ))
                ]),
                SizedBox(height: 10,),
                //product image and description
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        widget.product.imagePath,
                        width: 90,
                        height: 90,
                      ),
                      Expanded(
                        child: Text(
                          widget.product.description,
                          style: GoogleFonts.roboto(fontSize: 17, color: black),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //product size
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chọn Size',
                        style: GoogleFonts.arsenal(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      SizeProducts(
                        titleSize: 'S',
                        onSizeSelected: (selectedSize) {
                          setState(() {
                            this.selectedSize = selectedSize;
                          });
                        },
                      ),
                      SizeProducts(
                        titleSize: 'M',
                        onSizeSelected: (selectedSize) {
                          setState(() {
                            this.selectedSize = selectedSize;
                          });
                        },
                      ),
                      SizeProducts(
                        titleSize: 'L',
                        onSizeSelected: (selectedSize) {
                          setState(() {
                            this.selectedSize = selectedSize;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //product quantity
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    children: [
                      Text(
                        'Số lượng',
                        style: GoogleFonts.arsenal(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      SizedBox(width: 52),
                      Row(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: light_grey, shape: BoxShape.circle),
                              child: GestureDetector(
                                onTap: decrementQuantity,
                                child: Icon(
                                  Icons.remove,
                                  size: 19,
                                  color: white,
                                ),
                              )),
                          //quantity + count
                          SizedBox(
                            width: 35,
                            child: Center(
                              child: Text(
                                quantityCount.toString(),
                                style: GoogleFonts.roboto(
                                    fontSize: 17, color: black),
                              ),
                            ),
                          ),
                          Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primaryColors, shape: BoxShape.circle),
                              child: GestureDetector(
                                onTap: incrementQuantity,
                                child: Icon(
                                  Icons.add,
                                  size: 19,
                                  color: white,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //product price
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    children: [
                      Text(
                        'Tổng tiền',
                        style: GoogleFonts.arsenal(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        totalPrice.toStringAsFixed(3) + 'đ',
                        style: GoogleFonts.roboto(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: primaryColors),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                //button add to cart and buy now
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonAddToCart(
                          text: 'Thêm vào giỏ',
                          onTap: () {
                            addToCart(
                              widget.product.imagePath,
                              widget.product.name,
                              widget.product.newPrice,
                              totalPrice,
                              quantityCount,
                              selectedSize,
                            );
                          },
                        ),
                        VerticalDivider(
                          color: light_grey,
                          thickness: 1,
                        ),
                        ButtonBuyNow(text: 'Mua ngay', onTap: () {}),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
