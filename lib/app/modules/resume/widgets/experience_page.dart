import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../model/experience/experience_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/empty_screen/empty_screen.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';
import '../controllers/resume_controller.dart';
import 'education_page.dart';

class ExperiencePage extends GetView<ResumeController> {
  const ExperiencePage({Key? key}) : super(key: key);

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
          title:
              const Text('Your Experience', style: AppTextStyleConst.heading),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Experience Card
                Expanded(
                  child: Obx(
                    () => controller.experienceSection.isEmpty
                        ? const EmptyScreenWidget(
                            text: 'No Experience Added',
                            description:
                                'Add your experience to make your resume more attractive')
                        : ListView.builder(
                            itemCount: controller.experienceSection.length,
                            shrinkWrap: true,
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
                              // company name, duration, designation, summary
                              child: ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    // Delete Experience
                                    controller.deleteExperienceSection(
                                        controller.experienceSection[index]);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                onTap: () {
                                  // Set data to the controller
                                  controller
                                      .experienceCompanyTextEditingController
                                      .value
                                      .text = controller
                                          .experienceSection[index].company ??
                                      '';
                                  controller
                                      .experienceDesignationTextEditingController
                                      .value
                                      .text = controller
                                          .experienceSection[index]
                                          .designation ??
                                      '';
                                  controller
                                      .experienceDurationTextEditingController
                                      .value
                                      .text = controller
                                          .experienceSection[index].duration ??
                                      '';
                                  controller
                                      .experienceSummaryTextEditingController
                                      .value
                                      .text = controller
                                          .experienceSection[index]
                                          .description ??
                                      '';
                                  // Edit Experience Bottom Sheet
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    constraints: const BoxConstraints(
                                      maxHeight: 570,
                                    ),
                                    useRootNavigator: true,
                                    builder: (context) =>
                                        AddExperienceBottomsheet(
                                      isEdit: true,
                                      experience:
                                          controller.experienceSection[index],
                                    ),
                                  );
                                },
                                isThreeLine: true,
                                title: Text(
                                  controller.experienceSection[index]
                                          .designation ??
                                      '',
                                  style: AppTextStyleConst.heading,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.experienceSection[index]
                                              .company ??
                                          '',
                                      style: AppTextStyleConst.title2,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      controller.experienceSection[index]
                                              .duration ??
                                          '',
                                      style: AppTextStyleConst.subtitle,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      controller.experienceSection[index]
                                              .description ??
                                          '',
                                      style: AppTextStyleConst.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                ),

                // Add Experience Button
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Add Experience',
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    // Clear the text fields
                    controller.experienceCompanyTextEditingController.value
                        .clear();
                    controller.experienceDesignationTextEditingController.value
                        .clear();
                    controller.experienceDurationTextEditingController.value
                        .clear();
                    controller.experienceSummaryTextEditingController.value
                        .clear();
                    // Add Experience Bottom Sheet
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      constraints: const BoxConstraints(
                        maxHeight: 570,
                      ),
                      useRootNavigator: true,
                      builder: (context) => const AddExperienceBottomsheet(),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}

class AddExperienceBottomsheet extends GetView<ResumeController> {
  const AddExperienceBottomsheet({
    Key? key,
    this.isEdit = false,
    this.experience,
  }) : super(key: key);
  final bool? isEdit;
  final ExperienceModel? experience;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 20),
            Text(
              isEdit == true ? 'Update' : 'Add' ' Experience',
              style: AppTextStyleConst.heading,
            ),
            // Company Name, Designation, Duration, Summary
            const SizedBox(height: 20),
            PrimaryTextField(
              hintText: 'e.g. Google',
              labelText: 'Company Name',
              controller:
                  controller.experienceCompanyTextEditingController.value,
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              hintText: 'e.g. Software Engineer',
              labelText: 'Designation',
              controller:
                  controller.experienceDesignationTextEditingController.value,
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              hintText: 'e.g. Aug 2017 - Aug 2021',
              labelText: 'Duration',
              controller:
                  controller.experienceDurationTextEditingController.value,
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              hintText: 'e.g. Worked on Flutter, Firebase, and Google Cloud',
              labelText: 'Summary',
              maxLines: 2,
              controller:
                  controller.experienceSummaryTextEditingController.value,
            ),
            PrimaryButton(
              text: isEdit == true ? 'Update' : 'Save',
              icon: const Icon(Icons.save),
              onPressed: () {
                if (isEdit == true) {
                  controller.updateExperienceSection(
                    ExperienceModel(
                      id: experience?.id,
                      company: controller
                          .experienceCompanyTextEditingController.value.text,
                      designation: controller
                          .experienceDesignationTextEditingController
                          .value
                          .text,
                      duration: controller
                          .experienceDurationTextEditingController.value.text,
                      description: controller
                          .experienceSummaryTextEditingController.value.text,
                    ),
                  );
                } else {
                  controller.addExperienceSection(
                    ExperienceModel(
                      company: controller
                          .experienceCompanyTextEditingController.value.text,
                      designation: controller
                          .experienceDesignationTextEditingController
                          .value
                          .text,
                      duration: controller
                          .experienceDurationTextEditingController.value.text,
                      description: controller
                          .experienceSummaryTextEditingController.value.text,
                    ),
                    // ExperienceModel(
                    //   company: 'XYZ Company',
                    //   designation: 'Software Engineer',
                    //   duration: '2018 - 2019',
                    //   description:
                    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    // ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
