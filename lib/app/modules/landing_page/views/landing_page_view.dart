import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/shared/utils.dart';
import 'package:schieved/app/data/themes/color_themes.dart';
import 'package:schieved/app/routes/app_pages.dart';
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
          _bgImage(context),
          _pageIndicator(context),
          _textView(context),
        ],
      ),
    );
  }

  Widget _bgImage(context) {
    return SizedBox(
      height: screenHeight(context),
      width: screenWidth(context),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.imageController,
        children: [
          const Image(
            filterQuality: FilterQuality.high,
            width: double.maxFinite,
            height: double.maxFinite,
            isAntiAlias: true,
            image: AssetImage("assets/images/getstarted.png"),
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            height: screenHeight(context) * .05,
            width: screenWidth(context) * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  image: AssetImage("assets/illustration/landing-todo.png"),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: screenHeight(context) * .1,
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: screenHeight(context) * .05,
            width: screenWidth(context) * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  image: AssetImage("assets/illustration/landing-note.png"),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: screenHeight(context) * .1,
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: screenHeight(context) * .05,
            width: screenWidth(context) * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  image: AssetImage("assets/illustration/landing-goal.png"),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: screenHeight(context) * .1,
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: screenHeight(context) * .05,
            width: screenWidth(context) * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  image: AssetImage("assets/illustration/landing-last.png"),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: screenHeight(context) * .1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textView(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: screenHeight(context) * .15,
          width: double.maxFinite,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.textController,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
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
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
                  child: AutoSizeText.rich(
                    TextSpan(children: [
                      const TextSpan(text: 'Create a To Do List for today!'),
                      TextSpan(
                          text: '\nAdd title, description, tags and priority for your tasks',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ]),
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 4,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
                  child: AutoSizeText.rich(
                    TextSpan(children: [
                      const TextSpan(text: 'Note what’s important to you'),
                      TextSpan(
                          text: '\nnote it, pictures it, list it, voice notes and etc.',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ]),
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 4,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
                  child: AutoSizeText.rich(
                    TextSpan(children: [
                      const TextSpan(text: 'Don’t forget your goals!'),
                      TextSpan(
                          text: '\nYou must have some goals to achieve, create it, do it, and schieve it!',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ]),
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 4,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
                  child: AutoSizeText.rich(
                    TextSpan(children: [
                      const TextSpan(text: 'That’s it!'),
                      TextSpan(
                          text: '\nKeep it simple and stay on the track!',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ]),
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenHeight(context) * .2,
        ),
      ],
    );
  }

  Widget _pageIndicator(context) {
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      padding: EdgeInsets.symmetric(vertical: verticalPadding(context), horizontal: horizontalPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth(context) - horizontalPadding(context) * 2,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageIndicator(controller: controller.textController, count: 5),
                  ActionButton(
                      label: controller.btnLabel.value,
                      onPressed: () {
                        if (controller.btnLabel.value == 'Log In') {
                          getStorage.write('landed', true);
                          Get.offAllNamed(Routes.HOME);
                        } else {
                          controller.imageController
                              .nextPage(duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);

                          controller.textController
                              .nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);

                          if ((controller.textController.page ?? 0) == 0) {
                            controller.btnLabel.value = 'Next';
                          } else if ((controller.textController.page ?? 0) == 3) {
                            controller.btnLabel.value = 'Log In';
                          }
                        }
                      },
                      color: primaryColor)
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight(context) * .05,
          ),
        ],
      ),
    );
  }
}
