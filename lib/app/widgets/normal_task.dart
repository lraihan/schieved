import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schieved/app/data/models/task_model.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';
import 'package:schieved/app/widgets/custom_check_box.dart';
import 'package:schieved/app/widgets/strikethrought_text.dart';

class NormalTask extends StatelessWidget {
  final Task task;
  final Function onChecked;
  const NormalTask({super.key, required this.task, required this.onChecked});

  @override
  Widget build(BuildContext context) {
    final RxBool completed = (task.status == 'open' ? false : true).obs;
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * .02),
        width: double.maxFinite,
        height: screenHeight(context) * .04,
        decoration: BoxDecoration(
            color: completed.value ? neutralColor : Colors.transparent,
            border: Border.all(color: neutralColor),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Row(
            children: [
              CustomCheckBox(
                value: completed.value,
                onChanged: () {
                  onChecked();
                },
              ),
              SizedBox(
                width: screenWidth(context) * .015,
              ),
              SizedBox(
                width: screenWidth(context) * .77,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Text(
                      task.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: completed.value ? blackColor.shade200 : blackColor),
                    ),
                    if (completed.value) ...[StrikethroughtText(text: task.title)]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
