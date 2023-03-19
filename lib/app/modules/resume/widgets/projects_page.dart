import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';
import 'package:simple_resume_builder_app/app/modules/resume/controllers/resume_controller.dart';

import '../../../model/project/project_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

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
          title: const Text('Your Projects', style: AppTextStyleConst.heading),
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
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onLongPress: () {},
                    isThreeLine: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Calculator App',
                          style: AppTextStyleConst.heading,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Edit Project
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue[900]!,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Delete Project
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[900],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A simple calculator app made using Flutter',
                          style: AppTextStyleConst.subtitle,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Flutter, Dart',
                              style: AppTextStyleConst.caption,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '2021',
                              style: AppTextStyleConst.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Add Projects
                    },
                  ),
                ),

                // Add Projects Button
                const Expanded(child: SizedBox()),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Add Projects',
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Add Projects Bottom Sheet
                    Get.bottomSheet(
                      const AddProjectsBottomsheet(),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}

class AddProjectsBottomsheet extends GetView<ResumeController> {
  const AddProjectsBottomsheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 610,
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
            'Add Projects',
            style: AppTextStyleConst.heading,
          ),
          const SizedBox(height: 20),
          const PrimaryTextField(
            hintText: 'e.g. Calculator App',
            labelText: 'Project Name',
          ),
          const SizedBox(height: 20),
          const PrimaryTextField(
            hintText: 'e.g. A simple calculator app made using Flutter',
            labelText: 'Summary',
          ),
          const SizedBox(height: 20),
          const PrimaryTextField(
            hintText: 'e.g. Flutter, Dart',
            labelText: 'Tech Stack',
          ),
          const SizedBox(height: 20),
          const PrimaryTextField(
            hintText: 'e.g. 2021',
            labelText: 'Year',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            text: 'Save',
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save Projects
              controller.addProjectSection(
                ProjectModel(
                  project: 'Project 1',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  year: '2020',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
