import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlideImage extends StatefulWidget {
  final double? height;

  SlideImage({Key? key, required this.height}) : super(key: key);

  @override
  State<SlideImage> createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  int activeIndex = 0;
  final controller = CarouselController();
  final imagePaths = [
    'assets/images/slide/slide-1.jpg',
    'assets/images/slide/slide-2.jpg',
    'assets/images/slide/slide-3.jpg',
    'assets/images/slide/slide-4.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: imagePaths.length,
          itemBuilder: (context, index, realIndex) {
            final imagePath = imagePaths[index];
            return buildImage(imagePath, index);
          },
          options: CarouselOptions(
            height: widget.height ?? 200.0, // Sử dụng widget.height hoặc giá trị mặc định
            autoPlay: true,
            enableInfiniteScroll: false,
            autoPlayAnimationDuration: Duration(seconds: 3),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(() => activeIndex = index),
          ),
        ),
        SizedBox(height: 10),
        buildIndicator()
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(dotHeight: 5, dotWidth: 5, activeDotColor: primaryColors),
        activeIndex: activeIndex,
        count: imagePaths.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String imagePath, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    ),
  );
}
