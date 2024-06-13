import 'package:flutter/material.dart';
import 'package:get/get.dart';

//check if user has completed the landing page
final RxBool landed = false.obs;

double screenWidth(context) => MediaQuery.of(context).size.width;
double screenHeight(context) => MediaQuery.of(context).size.height;

double horizontalPadding(context) => screenWidth(context) * .08;
double verticalPadding(context) => screenHeight(context) * .04;
