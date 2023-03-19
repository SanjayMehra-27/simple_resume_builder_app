import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_resume_builder_app/app/constants/app_constatnt.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive & create a Hive box
  await Hive.initFlutter();
  await Hive.openBox(resume_box_name);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Resume Builder App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
