import 'package:flutter/material.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  const PageIndicator({super.key, required this.controller, required this.count});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        dotColor: neutralColor,
        activeDotColor: primaryColor,
        dotHeight: screenHeight(context) * 0.02,
        dotWidth: screenWidth(context) * 0.05,
      ),
    );
  }
}
