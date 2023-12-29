import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlandcoffeeapp/pages/detail/product_detail_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/util/product/product_form.dart';
import 'package:highlandcoffeeapp/models/products.dart';

class SearchResultPage extends StatefulWidget {
  final List<Products> searchResults;

  const SearchResultPage({required this.searchResults});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final _textSearchController = TextEditingController();
  List<Products> searchResults = [];
  //

  void performSearch(String query) {
    if (query.isEmpty) {
      // If the search query is empty, clear the search results
      setState(() {
        searchResults.clear();
      });
      return;
    }
    FirebaseFirestore.instance
        .collection('Danh sách sản phẩm')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + 'z')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<Products> newSearchResults = querySnapshot.docs
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
      if (newSearchResults.isEmpty) {
        String normalizedQuery = removeDiacritics(query.toLowerCase());
        newSearchResults = querySnapshot.docs
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

      setState(() {
        searchResults = newSearchResults;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultPage(searchResults: searchResults),
        ),
      );

      // In ra danh sách sản phẩm
      print('Search results: $searchResults');
    }).catchError((error) {
      print('Error searching products: $error');
    });
  }

  //
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
    //
    void _navigateToProductDetails(int index, List<Products> products) {
      // Add navigation logic to product details page as needed
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: products[index]),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                          _textSearchController.clear();
                        },
                      ),
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white))),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 18.0, top: 18.0, right: 18.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18.0,
            mainAxisSpacing: 18.0,
            childAspectRatio: 0.64,
          ),
          itemCount: widget.searchResults.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => _navigateToProductDetails(index, widget.searchResults),
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.searchResults[index].imagePath),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.searchResults[index].name,
                        style: GoogleFonts.arsenal(
                            color: black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.searchResults[index].oldPrice
                                    .toStringAsFixed(3) +
                                'đ',
                            style: GoogleFonts.roboto(
                                color: grey,
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.searchResults[index].newPrice
                                    .toStringAsFixed(3) +
                                'đ',
                            style: GoogleFonts.roboto(
                                color: primaryColors,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        // padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: primaryColors, shape: BoxShape.circle),
                        child: Icon(
                          Icons.add,
                          color: white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
