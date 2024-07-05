import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schieved/app/data/shared/shared_method.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';

class AppDate extends StatelessWidget {
  const AppDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            customFormatDate(todayDate.value, 'd'),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(
            width: screenWidth(context) * .01,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(customFormatDate(todayDate.value, 'MMMM'), style: Theme.of(context).textTheme.labelSmall),
              AutoSizeText(customFormatDate(todayDate.value, 'yyyy'), style: Theme.of(context).textTheme.labelSmall),
            ],
          )
        ],
      ),
    );
  }
}
