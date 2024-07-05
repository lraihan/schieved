import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: isLoading.value,
        child: PopScope(
          canPop: false,
          child: Scaffold(
            backgroundColor: blackColor.withOpacity(.7),
            body: Center(
              child: LoadingAnimationWidget.fourRotatingDots(color: primaryColor, size: screenWidth(context) * .3),
            ),
          ),
        ),
      ),
    );
  }
}
