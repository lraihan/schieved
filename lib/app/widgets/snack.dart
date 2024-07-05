import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';

enum SnackType { info, warning, error }

class Snack {
  static show({
    required String content,
    SnackType snackType = SnackType.info,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
  }) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: TweenAnimationBuilder<double>(
          curve: Curves.easeInOut,
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Text(content),
        ),
        behavior: behavior,
        backgroundColor: _getSnackbarColor(snackType),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding(Get.context!), vertical: verticalPadding(Get.context!) * .2),
      ),
    );
  }

  static Color _getSnackbarColor(SnackType type) {
    if (type == SnackType.error) return errorColor;
    if (type == SnackType.warning) return secondaryColor;
    if (type == SnackType.info) return primaryColor;
    return whiteColor;
  }

  static Color _getSnackbarTextColor(SnackType type) {
    if (type == SnackType.error || type == SnackType.info) return whiteColor;

    return const Color(0xff1C1C1C);
  }
}
