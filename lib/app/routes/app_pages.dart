import 'package:get/get.dart';

import '../data/shared/shared_variables.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing_page/bindings/landing_page_binding.dart';
import '../modules/landing_page/views/landing_page_view.dart';

// ignore_for_file: non_constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL = landed.value ? Routes.HOME : Routes.LANDING_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_PAGE,
      page: () => const LandingPageView(),
      binding: LandingPageBinding(),
    ),
  ];
}
