import 'package:get/get.dart';

import '../modules/resume/bindings/resume_binding.dart';
import '../modules/resume/views/resume_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.RESUME;

  static final routes = [
    GetPage(
      name: _Paths.RESUME,
      page: () => const ResumeView(),
      binding: ResumeBinding(),
    ),
  ];
}
