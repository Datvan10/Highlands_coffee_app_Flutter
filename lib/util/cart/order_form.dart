import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/components/button/button_authentication.dart';
import 'package:highlandcoffeeapp/pages/cart/cart_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class OrderForm extends StatefulWidget {
  final List<CartItem> cartItems;
  const OrderForm({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 650,
          child: ListView.builder(
            scrollDirection:
                Axis.vertical, // Để cho phép cuộn theo chiều ngang
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) {
              var item = widget.cartItems[index];
              return Slidable(
                startActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(onPressed: ((context){
                    Get.toNamed('/home_page');
                  }),
                  borderRadius: BorderRadius.circular(18.0),
                  backgroundColor: Colors.transparent,
                  foregroundColor: blue,
                  label: 'Trang chủ',
                  icon: Icons.home,
                  )
                ]),
                endActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(onPressed: ((context){
                    //comand delete
                  }),
                  borderRadius: BorderRadius.circular(18.0),
                  backgroundColor: Colors.transparent,
                  foregroundColor: red,
                  label: 'Xóa',
                  icon: Icons.delete,
                  ),
                ]),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 10), // Khoảng cách giữa các Container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(item.productImage, height: 70.0, width: 70.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: GoogleFonts.arsenal(
                                  fontSize: 16,
                                  color: primaryColors,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              item.totalPrice.toStringAsFixed(3) + 'đ',
                              style: GoogleFonts.roboto(
                                color: primaryColors,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text('Quantity: ${item.quantity}'),
                            Row(
                              children: [
                                Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: primaryColors,
                                        shape: BoxShape.circle),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Xử lý khi nhấn nút giảm
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 15,
                                        color: white,
                                      ),
                                    )),
                                //quantity + count
                                SizedBox(
                                  width: 35,
                                  child: Center(
                                    child: Text(
                                      item.quantity.toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 15, color: black),
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: primaryColors,
                                        shape: BoxShape.circle),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Xử lý khi nhấn nút thêm
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: white,
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            // Text('Size: ${item.selectedSize}'),
                            Container(
                              height: 25,
                              width: 50,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                  color: primaryColors,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  item.selectedSize,
                                  style: GoogleFonts.arsenal(
                                      color: primaryColors,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
