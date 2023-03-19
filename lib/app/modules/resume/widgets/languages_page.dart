import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../model/language/language_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';
import '../controllers/resume_controller.dart';

class LanguagesPage extends GetView<ResumeController> {
  const LanguagesPage({Key? key}) : super(key: key);

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
          title: const Text('Your Languages', style: AppTextStyleConst.heading),
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
                const SizedBox(height: 50),
                // Languages
                PrimaryTextField(
                  hintText: 'e.g. English, Hindi, etc',
                  labelText: 'You Speak ...',
                  controller: controller.languagesTextEditingController.value,
                ),
                const SizedBox(height: 20),
                // Proficiency Level [Beginner, Intermediate, Advanced] [Selectable Chips]
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Select Beginner
                          controller.languagesProficiency.value = 'Beginner';
                        },
                        child: Chip(
                          label: const Text('Beginner'),
                          backgroundColor:
                              controller.languagesProficiency.value ==
                                      'Beginner'
                                  ? Colors.green
                                  : Colors.grey[400],
                          labelStyle: const TextStyle(color: Colors.white),
                          elevation: 0.1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Select Intermediate
                          controller.languagesProficiency.value =
                              'Intermediate';
                        },
                        child: Chip(
                          label: const Text('Intermediate'),
                          backgroundColor:
                              controller.languagesProficiency.value ==
                                      'Intermediate'
                                  ? Colors.green
                                  : Colors.grey[400],
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Select Advanced
                          controller.languagesProficiency.value = 'Advanced';
                        },
                        child: Chip(
                          label: const Text('Advanced'),
                          backgroundColor:
                              controller.languagesProficiency.value ==
                                      'Advanced'
                                  ? Colors.green
                                  : Colors.grey[400],
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Add Languages',
                  color: Colors.green,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    controller.addLanguageSection(
                      LanguageModel(
                        language: controller
                            .languagesTextEditingController.value.text,
                        level: controller.languagesProficiency.value,
                      ),
                    );
                    // Clear the text field
                    controller.languagesTextEditingController.value.clear();
                  },
                ),

                const SizedBox(height: 20),
                // Languages List
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      itemCount: controller.languagesSection.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              controller.languagesSection[index].language ??
                                  ''),
                          subtitle: Text(
                              controller.languagesSection[index].level ?? ''),
                          trailing: IconButton(
                            onPressed: () {
                              // Delete Languages
                              controller.deleteLanguageSection(
                                  controller.languagesSection[index]);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
                  ),
                ),

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
