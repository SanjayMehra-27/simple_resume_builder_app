import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';
import 'package:simple_resume_builder_app/app/modules/resume/controllers/resume_controller.dart';

import '../../../model/project/project_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/empty_screen/empty_screen.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';

class ProjectsPage extends GetView<ResumeController> {
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
                Expanded(
                  child: Obx(
                    () => controller.projectsSection.isEmpty
                        ? const EmptyScreenWidget(
                            text: 'No Projects Added',
                            description:
                                ' Add your projects to showcase your skills and experience')
                        : ListView.builder(
                            itemCount: controller.projectsSection.length,
                            itemBuilder: (context, index) => Container(
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
                                trailing: IconButton(
                                  onPressed: () {
                                    // Delete Project
                                    controller.deleteProjectSection(
                                        controller.projectsSection[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                                title: Text(
                                  controller.projectsSection[index].project ??
                                      '',
                                  style: AppTextStyleConst.heading,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.projectsSection[index]
                                              .description ??
                                          '',
                                      style: AppTextStyleConst.subtitle,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Tech Stack:  ${controller.projectsSection[index].techStack}',
                                          style: AppTextStyleConst.caption,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Year:  ${controller.projectsSection[index].year}',
                                          style: AppTextStyleConst.caption,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // Set the project controller to the project
                                  controller.projectsNameTextEditingController
                                      .value.text = controller
                                          .projectsSection[index].project ??
                                      '';
                                  controller
                                      .projectsSummaryTextEditingController
                                      .value
                                      .text = controller
                                          .projectsSection[index].description ??
                                      '';
                                  controller
                                      .projectsTechStackTextEditingController
                                      .value
                                      .text = controller
                                          .projectsSection[index].techStack ??
                                      '';

                                  controller.projectsYearTextEditingController
                                      .value.text = controller
                                          .projectsSection[index].techStack ??
                                      '';

                                  // Update Projects
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    constraints: const BoxConstraints(
                                      maxHeight: 570,
                                    ),
                                    useRootNavigator: true,
                                    builder: (context) =>
                                        AddProjectsBottomsheet(
                                      isEdit: true,
                                      project:
                                          controller.projectsSection[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                  ),
                ),
                // Add Projects Button
                // const Expanded(child: SizedBox()),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Add Projects',
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    // Clear the text fields
                    controller.projectsNameTextEditingController.value.clear();
                    controller.projectsSummaryTextEditingController.value
                        .clear();
                    controller.projectsTechStackTextEditingController.value
                        .clear();
                    controller.projectsYearTextEditingController.value.clear();

                    // Add Projects Bottom Sheet
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      constraints: const BoxConstraints(
                        maxHeight: 570,
                      ),
                      useRootNavigator: true,
                      builder: (context) => const AddProjectsBottomsheet(),
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
    this.isEdit = false,
    this.project,
  }) : super(key: key);
  final bool isEdit;
  final ProjectModel? project;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 610,
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
          Text(
            isEdit ? 'Update Projects' : 'Add Projects',
            style: AppTextStyleConst.heading,
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            controller: controller.projectsNameTextEditingController.value,
            hintText: 'e.g. Calculator App',
            labelText: 'Project Name',
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            controller: controller.projectsSummaryTextEditingController.value,
            hintText: 'e.g. A simple calculator app made using Flutter',
            labelText: 'Summary',
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            controller: controller.projectsTechStackTextEditingController.value,
            hintText: 'e.g. Flutter, Dart',
            labelText: 'Tech Stack',
          ),
          const SizedBox(height: 20),
          PrimaryTextField(
            controller: controller.projectsYearTextEditingController.value,
            hintText: 'e.g. 2021',
            labelText: 'Year',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            text: isEdit ? 'Update' : 'Save',
            icon: const Icon(Icons.save),
            onPressed: () {
              if (isEdit == true) {
                controller.updateProjectSection(
                  ProjectModel(
                    id: project!.id,
                    project:
                        controller.projectsNameTextEditingController.value.text,
                    description: controller
                        .projectsSummaryTextEditingController.value.text,
                    techStack: controller
                        .projectsTechStackTextEditingController.value.text,
                    year:
                        controller.projectsYearTextEditingController.value.text,
                  ),
                );
              } else {
                controller.addProjectSection(
                  ProjectModel(
                    project:
                        controller.projectsNameTextEditingController.value.text,
                    description: controller
                        .projectsSummaryTextEditingController.value.text,
                    techStack: controller
                        .projectsTechStackTextEditingController.value.text,
                    year:
                        controller.projectsYearTextEditingController.value.text,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
