import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/models/tickets.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';

class DiscountCodeForm extends StatefulWidget {
  final List<Tickets> discountTickets;

  const DiscountCodeForm({Key? key, required this.discountTickets})
      : super(key: key);

  @override
  State<DiscountCodeForm> createState() => _DiscountCodeFormState();
}

class _DiscountCodeFormState extends State<DiscountCodeForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      width: double.infinity,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical, // Set scroll direction to vertical
        itemCount: widget.discountTickets.length,
        itemBuilder: (context, index) {
          Tickets ticket = widget.discountTickets[index];
          return Container(
            height: 130,
            margin: EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      bottomLeft: Radius.circular(18.0),
                    ),
                    child: Image.asset(ticket.imagePath, height: 130.0, fit: BoxFit.cover,),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket.name,
                            style: GoogleFonts.arsenal(
                              color: primaryColors,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ticket.description,
                            style: GoogleFonts.arsenal(
                              color: black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ticket.date,
                            style: GoogleFonts.arsenal(
                              color: grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      //message with IOS
                      showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text("Thông báo", style: GoogleFonts.arsenal(color: primaryColors,
                                  fontWeight: FontWeight.bold, fontSize: 18),),
                            content: Text("Sử dụng mã giảm giá thành công!", style: TextStyle(fontSize: 16),),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text("OK",style: TextStyle(color: blue, ),),
                              ),
                            ],
                          );
                        },
                      );
                      //message with IOS
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: Text(
                      //         "Thông báo",
                      //         style: GoogleFonts.arsenal(
                      //             color: primaryColors,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //       content: Text("Sử dụng mã giảm giá thành công!"),
                      //       actions: [
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.of(context)
                      //                 .pop();
                      //           },
                      //           child: Text(
                      //             "OK",
                      //             style: TextStyle(color: blue),
                      //           ),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                    },
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(18.0),
                          bottomRight: Radius.circular(18.0),
                        ),
                        color: primaryColors,
                      ),
                      child: Center(
                        child: Text(
                          'Áp Dụng',
                          style: GoogleFonts.arsenal(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
