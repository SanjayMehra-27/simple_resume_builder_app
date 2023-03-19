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
                PrimaryTextField(
                  hintText: 'e.g. Flutter, Dart, Firebase, etc.',
                  labelText: 'Your Skills',
                  suffix: Container(
                    height: 35,
                    padding: const EdgeInsets.all(5),
                    child: FloatingActionButton(
                      onPressed: () {
                        controller.addSkillsSection(SkillModel(
                          id: 1,
                          skill: 'Flutter',
                        ));
                      },
                      child: const Icon(Icons.add),
                      backgroundColor: Colors.green,
                      elevation: 0.1,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Skills List
                Expanded(
                  child: ListView(
                    children: const [
                      ListTile(
                        title: Text('Flutter'),
                        trailing: Icon(Icons.close),
                      ),
                      ListTile(
                        title: Text('Dart'),
                        trailing: Icon(Icons.close),
                      ),
                      ListTile(
                        title: Text('Firebase'),
                        trailing: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                // Add Skills Button
                const Expanded(child: SizedBox()),
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

class AddSkillsBottomsheet extends GetView<ResumeController> {
  const AddSkillsBottomsheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Add Skills',
            style: AppTextStyleConst.heading,
          ),
          const SizedBox(height: 20),
          const PrimaryTextField(
            hintText: 'e.g. Bachelor of Engineering',
            labelText: 'Degree',
          ),
          const SizedBox(height: 20),
          const PrimaryTextField(
            hintText: 'e.g. University of Engineering and Technology',
            labelText: 'Institute',
          ),
          const SizedBox(height: 20),
          const PrimaryTextField(
            hintText: 'e.g. Aug 2017 - Aug 2021',
            labelText: 'Duration',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            text: 'Save',
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save Skills
              controller.addSkillsSection(SkillModel(
                id: 1,
                skill: 'Flutter',
              ));
            },
          ),
        ],
      ),
    );
  }
}
