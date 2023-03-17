import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';
import '../controllers/resume_controller.dart';
import 'add_details_view.dart';

class ResumeView extends GetView<ResumeController> {
  const ResumeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open the Add Details page
          Get.to(
            () => const AddDetailsView(),
            transition: Transition.downToUp,
            fullscreenDialog: true,
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Your Resume',
          style: AppTextStyleConst.heading,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.person_add,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please add your details to see your resume.',
              textAlign: TextAlign.center,
              style: AppTextStyleConst.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
