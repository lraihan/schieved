import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:schieved/app/data/models/tag_model.dart';
import 'package:schieved/app/data/models/task_model.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';
import 'package:schieved/app/widgets/custom_check_box.dart';
import 'package:schieved/app/widgets/custom_ticker.dart';

class HighprioTask extends StatelessWidget {
  final Task task;
  final Tag tag;
  final Function onChecked;
  const HighprioTask({super.key, required this.task, required this.tag, required this.onChecked});

  @override
  Widget build(BuildContext context) {
    final RxBool completed = (task.status == 'open' ? false : true).obs;
    final AnimationController animationController = AnimationController(vsync: CustomTickerProvider());
    return Obx(
      () => Animate(
        value: 1,
        autoPlay: false,
        effects: const [FadeEffect(curve: Curves.easeInOut, duration: Duration(milliseconds: 600))],
        controller: animationController,
        child: Container(
          width: screenWidth(context) * .45,
          height: screenHeight(context) * .1,
          padding: EdgeInsets.symmetric(vertical: screenHeight(context) * .01, horizontal: screenWidth(context) * .02),
          decoration: BoxDecoration(
              color: completed.value ? neutralColor : Colors.transparent,
              border: Border.all(color: neutralColor),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCheckBox(
                    value: completed.value,
                    onChanged: () async {
                      await animationController.reverse();
                      onChecked();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * .02),
                    height: screenWidth(context) * .05,
                    width: screenWidth(context) * .34,
                    decoration: BoxDecoration(
                        color: Color(int.parse('0X33${tag.color}')),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                        child: AutoSizeText(
                      tag.name,
                      maxLines: 1,
                      style: TextStyle(color: Color(int.parse('0XFF${tag.color}'))),
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context) * .008,
              ),
              Stack(
                children: [
                  Text(
                    task.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: completed.value ? blackColor.shade200 : blackColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
