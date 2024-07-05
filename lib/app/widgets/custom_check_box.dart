import 'package:flutter/material.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final Function? onChanged;
  const CustomCheckBox({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return value
        ? InkWell(
            onTap: onChanged != null
                ? () {
                    Future.delayed(Duration.zero, () async {
                      onChanged!();
                    });
                  }
                : () {},
            child: Container(
              height: screenWidth(context) * .05,
              width: screenWidth(context) * .05,
              decoration:
                  BoxDecoration(border: Border.all(color: primaryColor), borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Container(
                  height: screenWidth(context) * .035,
                  width: screenWidth(context) * .035,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
            ),
          )
        : InkWell(
            onTap: onChanged != null
                ? () {
                    Future.delayed(Duration.zero, () async {
                      onChanged!();
                    });
                  }
                : () {},
            child: Container(
              height: screenWidth(context) * .05,
              width: screenWidth(context) * .05,
              decoration: BoxDecoration(border: Border.all(color: blackColor), borderRadius: BorderRadius.circular(5)),
            ),
          );
  }
}
