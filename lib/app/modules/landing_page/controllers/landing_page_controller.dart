import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageController extends GetxController {
  final PageController imageController = PageController();
  final PageController textController = PageController();

  final RxString btnLabel = 'Get Started'.obs;
}
