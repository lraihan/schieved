import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/shared/utils.dart';
import 'package:schieved/app/data/themes/color_themes.dart';
import 'package:schieved/app/widgets/action_button.dart';
import 'package:schieved/app/widgets/page_indicator.dart';

import '../controllers/landing_page_controller.dart';

class LandingPageView extends GetView<LandingPageController> {
  const LandingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight(context),
            width: screenWidth(context),
            child: PageView(
              controller: controller.pageController,
              children: const [
                Image(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  isAntiAlias: true,
                  image: AssetImage("assets/images/getstarted.png"),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight(context),
            width: screenWidth(context),
            padding: EdgeInsets.symmetric(vertical: verticalPadding(context), horizontal: horizontalPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: screenHeight(context) * .15,
                  width: double.maxFinite,
                  child: PageView(
                    controller: controller.pageController,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(text: 'Schedule ', style: TextStyle(color: primaryColor)),
                            const TextSpan(text: 'Your Task and '),
                            TextSpan(text: 'Achieve ', style: TextStyle(color: secondaryColor)),
                            const TextSpan(text: 'Your Goals!'),
                          ]),
                          style: Theme.of(context).textTheme.headlineLarge,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * .05,
                ),
                SizedBox(
                  width: screenWidth(context) - horizontalPadding(context) * 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PageIndicator(controller: controller.pageController, count: 5),
                      ActionButton(label: 'Get Started', onPressed: () {}, color: primaryColor)
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * .05,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
