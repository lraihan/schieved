import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:schieved/app/data/shared/shared_method.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/shared/utils.dart';
import 'package:schieved/app/data/themes/color_themes.dart';
import 'package:schieved/app/widgets/action_button.dart';
import 'package:schieved/app/widgets/app_date.dart';
import 'package:schieved/app/widgets/highprio_task.dart';
import 'package:schieved/app/widgets/loading.dart';
import 'package:schieved/app/widgets/normal_task.dart';
import 'package:schieved/app/widgets/weekly_date.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:weekly_date_picker/datetime_apis.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          if (userMaster.value.uid != null) {
            return _homeView(context);
          } else {
            return _loginView(context);
          }
        }),
        const Loading(),
      ],
    );
  }

  Widget _homeView(context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.streamService.taskStream(startOfWeek.value, endOfWeek.value),
        builder: (context, snapshot) {
          controller.filterTask(snapshot);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              foregroundColor: whiteColor,
              backgroundColor: primaryColor,
              onPressed: () {},
              child: Icon(
                Icons.add,
                size: screenHeight(context) * .04,
              ),
            ),
            body: Stack(
              children: [
                Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  padding:
                      EdgeInsets.symmetric(vertical: verticalPadding(context), horizontal: horizontalPadding(context)),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppDate(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(customFormatDate(todayDate.value, 'EEEE'),
                                    style: Theme.of(context).textTheme.titleMedium),
                                SizedBox(
                                  width: screenWidth(context) * .015,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.menu,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight(context) * .01,
                        ),
                        _weeklyStatsCard(context),
                        SizedBox(
                          height: screenHeight(context) * .01,
                        ),
                        WeeklyDate(
                          controller: controller.weekController,
                          selectedDigitColor: primaryColor,
                          selectedDigitBackgroundColor: Colors.transparent,
                          digitsColor: blackColor.shade200,
                          selectedDay: todayDate.value,
                          changeDay: (value) {
                            todayDate.value = value;
                            controller.filterTask(snapshot);
                          },
                        ),
                        SizedBox(
                          height: screenHeight(context) * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.arrow_back),
                                  SizedBox(
                                    width: screenWidth(context) * .01,
                                  ),
                                  AutoSizeText(
                                    'Goals',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            if (!(todayDate.value.isSameDateAs(DateTime.now()))) ...[
                              GestureDetector(
                                onTap: () async {
                                  await controller.weekController.animateToPage(520,
                                      duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
                                  todayDate.value = DateTime.now();
                                  controller.filterTask(snapshot);
                                },
                                child: Animate(
                                  effects: const [FadeEffect(duration: Duration(milliseconds: 800))],
                                  child: AutoSizeText(
                                    'Today\'s Date',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: primaryColor),
                                  ),
                                ),
                              ),
                            ],
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AutoSizeText(
                                    'Notes',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: primaryColor),
                                  ),
                                  SizedBox(
                                    width: screenWidth(context) * .01,
                                  ),
                                  const Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight(context) * .01,
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: screenWidth(context),
                        height: screenHeight(context) * .645,
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: horizontalPadding(context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          todayDate.value.isSameDateAs(DateTime.now())
                                              ? 'Today\'s Task'
                                              : 'This day\'s Task',
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: AutoSizeText(
                                            'See all task',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(color: blackColor.shade200),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (controller.completedTask.length != controller.totalTask.value) ...[
                                      AutoSizeText(
                                        '${controller.totalTask.value} Total Task',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: blackColor),
                                      ),
                                    ] else if (controller.totalTask.value != 0) ...[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: positiveColor,
                                          ),
                                          SizedBox(
                                            width: screenWidth(context) * .02,
                                          ),
                                          AutoSizeText(
                                            'Today\'s Task Completed',
                                            style:
                                                Theme.of(context).textTheme.titleSmall!.copyWith(color: positiveColor),
                                          ),
                                        ],
                                      )
                                    ] else if (controller.overdueTask.isNotEmpty) ...[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: blackColor.shade200,
                                          ),
                                          SizedBox(
                                            width: screenWidth(context) * .02,
                                          ),
                                          AutoSizeText(
                                            'No task for today, but you have overdue task',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(color: blackColor.shade200),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: screenHeight(context) * .01,
                                      ),
                                    ],
                                    if (controller.totalTask.value != 0) ...[
                                      if (controller.highPrioTask.isNotEmpty) ...[
                                        SizedBox(
                                          height: screenHeight(context) * .11,
                                        ),
                                      ],
                                      SizedBox(
                                        height: screenHeight(context) * .02,
                                      ),
                                      _taskSection(context),
                                    ],
                                    if (controller.overdueTask.isNotEmpty) ...[
                                      AutoSizeText(
                                        'Overdue Task',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      AutoSizeText(
                                        '${controller.totalOverdueTask.value} Task Overdue',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: blackColor),
                                      ),
                                      SizedBox(
                                        height: screenHeight(context) * .01,
                                      ),
                                      _overdueSection(context),
                                    ],
                                    if (controller.completedTask.isNotEmpty) ...[
                                      AutoSizeText(
                                        'Task Completed',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      AutoSizeText(
                                        '${controller.completedTask.length}/${controller.totalTask.value} Task Completed',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: blackColor),
                                      ),
                                      SizedBox(
                                        height: screenHeight(context) * .01,
                                      ),
                                      _completedSection(context),
                                    ],
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: screenHeight(context) * .04,
                                  ),
                                  if (controller.totalTask.value == 0 && controller.overdueTask.isEmpty) ...[
                                    _emptySection(context),
                                  ],
                                  if (controller.highPrioTask.isNotEmpty) ...[
                                    SizedBox(
                                      height: screenHeight(context) * .015,
                                    ),
                                    _highPrioritySection(context),
                                  ]
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ), /* 
                if (snapshot.connectionState == ConnectionState.waiting) ...[
                  Scaffold(
                    backgroundColor: blackColor.withOpacity(.7),
                    body: Center(
                      child:
                          LoadingAnimationWidget.fourRotatingDots(color: primaryColor, size: screenWidth(context) * .3),
                    ),
                  ),
                ], */
              ],
            ),
          );
        });
  }

  Widget _loginView(context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                'schieved',
                style: Theme.of(context).textTheme.headlineLarge!.apply(color: primaryColor),
              ),
              AutoSizeText(
                'Hello!',
                style: Theme.of(context).textTheme.bodyLarge!.apply(color: blackColor.shade200),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ActionButton(
                label: 'Sign In With Google',
                onPressed: () => controller.signInWithGoogle(),
                color: primaryColor,
                width: screenWidth(context) * .55,
              ),
              SizedBox(
                height: verticalPadding(context) * .5,
              ),
              AutoSizeText(
                'a simple, minimalistic task manager',
                style: Theme.of(context).textTheme.bodyLarge!.apply(color: blackColor.shade200),
              ),
              SizedBox(
                height: screenHeight(context) * .12,
              )
            ],
          ),
        )
      ],
    ));
  }

  Widget _weeklyStatsCard(context) {
    return Card(
      color: whiteColor.shade400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: verticalPadding(context) * .2, horizontal: horizontalPadding(context) * .5),
        width: double.maxFinite,
        height: screenHeight(context) * .12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await controller.weekController
                        .previousPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
                  },
                  child: AutoSizeText(
                    'prev week',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: primaryColor),
                  ),
                ),
                AutoSizeText(
                  'Weekly Stats',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                InkWell(
                  onTap: () async {
                    await controller.weekController
                        .nextPage(duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
                  },
                  child: AutoSizeText(
                    'next week',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: primaryColor),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding(context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth(context) * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          '0',
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: secondaryColor),
                        ),
                        AutoSizeText(
                          'Open Task',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: secondaryColor),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(context) * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          '0',
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: primaryColor),
                        ),
                        AutoSizeText(
                          'Completed',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: primaryColor),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(context) * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          '0',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        AutoSizeText(
                          'Created',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding(context),
              ),
              child: Container(
                height: screenHeight(context) * .008,
                width: double.maxFinite,
                decoration: BoxDecoration(color: neutralColor, borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _emptySection(context) {
    return SizedBox(
      width: double.maxFinite,
      height: screenHeight(context) * .55,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight(context) * .08,
          ),
          Opacity(
            opacity: 0.7,
            child: Image(
              filterQuality: FilterQuality.high,
              height: screenHeight(context) * .3,
              isAntiAlias: true,
              image: const AssetImage("assets/illustration/todo-empty.png"),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: screenWidth(context) * .05,
          ),
          AutoSizeText(
            'No task left, \nyou can create one for today',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: blackColor.shade200),
          ),
        ],
      ),
    );
  }

  Widget _highPrioritySection(context) {
    return SizedBox(
      height: screenHeight(context) * .103,
      width: double.maxFinite,
      child: ListView.builder(
        padding: EdgeInsets.only(left: horizontalPadding(context), right: horizontalPadding(context) * .5),
        itemCount: controller.highPrioTask.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: horizontalPadding(context) * .5),
            child: HighprioTask(
              task: controller.highPrioTask[index],
              tag: controller.tagList.firstWhere(
                (element) => element.id == controller.highPrioTask[index].tagIds[0],
              ),
              onChecked: () => controller.changeTaskStatus(controller.highPrioTask[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _taskSection(context) {
    return SizedBox(
      width: screenWidth(context),
      height: (screenHeight(context) * .06) * controller.todayTask.length,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.todayTask.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: verticalPadding(context) * .5),
              child: NormalTask(
                task: controller.todayTask[index],
                onChecked: () => controller.changeTaskStatus(controller.todayTask[index]),
              ),
            );
          }),
    );
  }

  Widget _overdueSection(context) {
    return SizedBox(
      width: screenWidth(context),
      height: (screenHeight(context) * .06) * controller.overdueTask.length,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.overdueTask.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: verticalPadding(context) * .5),
              child: NormalTask(
                task: controller.overdueTask[index],
                onChecked: () => controller.changeTaskStatus(controller.overdueTask[index]),
              ),
            );
          }),
    );
  }

  Widget _completedSection(context) {
    return SizedBox(
      width: screenWidth(context),
      height: (screenHeight(context) * .06) * controller.completedTask.length,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.completedTask.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: verticalPadding(context) * .5),
              child: NormalTask(
                task: controller.completedTask[index],
                onChecked: () => controller.changeTaskStatus(controller.completedTask[index]),
              ),
            );
          }),
    );
  }
}
