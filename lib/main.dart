import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/shared/utils.dart';
import 'package:schieved/app/data/themes/themes.dart';
import 'firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();

  landed.value = getStorage.read('landed') ?? false;

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "schieved",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: themeData,
      debugShowCheckedModeBanner: false,
    ),
  );
}
