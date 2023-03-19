import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';
import 'package:simple_resume_builder_app/app/modules/resume/controllers/resume_controller.dart';

import '../../../model/skill/skill_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';

class SkillsPage extends GetView<ResumeController> {
  const SkillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text('Your Skills', style: AppTextStyleConst.heading),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Close the Add Details page
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, color: Colors.black, size: 30),
          ),
        ),
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Obx(
                  () => PrimaryTextField(
                    hintText: 'e.g. Flutter, Dart, Firebase, etc.',
                    labelText: 'Your Skills',
                    controller: controller.skillsTextEditingController.value,
                    suffix: Container(
                      height: 35,
                      padding: const EdgeInsets.all(5),
                      child: FloatingActionButton(
                        onPressed: () {
                          controller.addSkillsSection(SkillModel(
                            skill: controller
                                .skillsTextEditingController.value.text,
                          ));
                          // Clear the text field
                          controller.skillsTextEditingController.value.clear();
                        },
                        backgroundColor: Colors.green,
                        elevation: 0.1,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Skills List
                Obx(() => Expanded(
                      child: ListView.builder(
                        itemCount: controller.skillsSection.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              controller.skillsSection[index].skill ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                controller.deleteSkillsSection(
                                    controller.skillsSection[index]);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    )),

                // Add Skills Button
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Go Back',
                  onPressed: () {
                    // Go back to the previous page
                    Navigator.pop(context);
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
