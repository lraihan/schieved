import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schieved/app/data/models/user_master_model.dart';
import 'package:schieved/app/data/shared/utils.dart';
import 'package:week_of_year/week_of_year.dart';

//check if user has completed the landing page
final RxBool landed = false.obs;

//check if its on loading state
final RxBool isLoading = false.obs;

double screenWidth(context) => MediaQuery.of(context).size.width;
double screenHeight(context) => MediaQuery.of(context).size.height;

double horizontalPadding(context) => screenWidth(context) * .06;
double verticalPadding(context) => screenHeight(context) * .03;

final Rx<UserMaster> userMaster = (UserMaster.fromMap(getStorage.read('userMaster') ?? UserMaster().toJson())).obs;

final Rx<DateTime> todayDate = DateTime.now().obs;

final Rx<DateTime> startOfWeek =
    dateTimeFromWeekNumber(todayDate.value.year, todayDate.value.weekOfYear - 1, DateTime.monday).obs;

final Rx<DateTime> endOfWeek = dateTimeFromWeekNumber(todayDate.value.year, todayDate.value.weekOfYear, DateTime.sunday)
    .add(const Duration(hours: 23, minutes: 59, seconds: 59))
    .obs;
