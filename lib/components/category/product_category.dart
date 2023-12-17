import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/components/pages/coffee_page.dart';
import 'package:highlandcoffeeapp/components/pages/freeze_page.dart';
import 'package:highlandcoffeeapp/components/pages/other_page.dart';
import 'package:highlandcoffeeapp/components/pages/sweet_cake_page.dart';
import 'package:highlandcoffeeapp/components/pages/tea_page.dart';
import 'package:highlandcoffeeapp/util/product/product_category_form.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key});

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductCategoryForm(
                  titleProduct: 'Cà phê',
                  destinationPage: CoffeePage(),
                ),
                ProductCategoryForm(
                  titleProduct: 'Freeze',
                  destinationPage: FreezePage(),
                ),
                ProductCategoryForm(
                  titleProduct: 'Trà',
                  destinationPage: TeaPage(),
                ),
                ProductCategoryForm(
                  titleProduct: 'Bánh ngọt',
                  destinationPage: SweetCakePage(),
                ),
                ProductCategoryForm(
                  titleProduct: 'Khác',
                  destinationPage: OtherPage(),
                )
              ],
            );
  }
}