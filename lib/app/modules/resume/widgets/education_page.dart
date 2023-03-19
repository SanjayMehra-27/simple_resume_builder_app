import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../model/education/education_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';
import '../controllers/resume_controller.dart';

class EducationPage extends GetView<ResumeController> {
  const EducationPage({Key? key}) : super(key: key);

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
          title: const Text('Your Education', style: AppTextStyleConst.heading),
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
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.educationSection.value.length,
                      itemBuilder: (context, index) {
                        return Container(
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
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[400],
                              ),
                              onPressed: () =>
                                  controller.deleteEducationSection(
                                      controller.educationSection[index]),
                            ),
                            isThreeLine: true,
                            title: Text(
                              controller.educationSection[index].degree ?? '',
                              style: AppTextStyleConst.heading,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller
                                          .educationSection[index].institute ??
                                      '',
                                  style: AppTextStyleConst.subtitle,
                                ),
                                Text(
                                  controller.educationSection[index].duration ??
                                      '',
                                  style: AppTextStyleConst.caption,
                                ),
                              ],
                            ),
                            onTap: () {
                              // set data
                              controller.educationDegreeTextEditingController
                                      .value.text =
                                  controller.educationSection[index].degree ??
                                      '';
                              controller.educationDurationTextEditingController
                                      .value.text =
                                  controller.educationSection[index].duration ??
                                      '';
                              controller.educationInstituteTextEditingController
                                  .value.text = controller
                                      .educationSection[index].institute ??
                                  '';

                              // Add Education
                              Get.bottomSheet(
                                AddEducationBottomsheet(
                                  education: controller.educationSection[index],
                                  isEdit: true,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )),

                // Add Education Button
                const Expanded(child: SizedBox()),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Add Education',
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Add Education Bottom Sheet
                    Get.bottomSheet(
                      const AddEducationBottomsheet(),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}

class AddEducationBottomsheet extends GetView<ResumeController> {
  const AddEducationBottomsheet({
    Key? key,
    this.education,
    this.isEdit = false,
  }) : super(key: key);

  final bool? isEdit;
  final EducationModel? education;

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
      child: Obx(
        () => Column(
          children: [
            const SizedBox(height: 20),
            Text(
              isEdit == true ? 'Update Education' : 'Add Education',
              style: AppTextStyleConst.heading,
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
                hintText: 'e.g. Bachelor of Engineering',
                labelText: 'Degree',
                controller:
                    controller.educationDegreeTextEditingController.value),
            const SizedBox(height: 20),
            PrimaryTextField(
              hintText: 'e.g. University of Engineering and Technology',
              labelText: 'Institute',
              controller:
                  controller.educationInstituteTextEditingController.value,
            ),
            const SizedBox(height: 20),
            PrimaryTextField(
              hintText: 'e.g. Aug 2017 - Aug 2021',
              labelText: 'Duration',
              controller:
                  controller.educationDurationTextEditingController.value,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: isEdit == true ? 'Update' : 'Save',
              icon: const Icon(Icons.save),
              onPressed: () async {
                bool isAdded = false;
                if (isEdit == true) {
                  isAdded =
                      await controller.updateEducationSection(EducationModel(
                    id: education?.id,
                    institute: controller
                        .educationInstituteTextEditingController.value.text,
                    degree: controller
                        .educationDegreeTextEditingController.value.text,
                    duration: controller
                        .educationDurationTextEditingController.value.text,
                  ));
                } else {
                  isAdded = await controller.addEducationSection(EducationModel(
                    institute: controller
                        .educationInstituteTextEditingController.value.text,
                    degree: controller
                        .educationDegreeTextEditingController.value.text,
                    duration: controller
                        .educationDurationTextEditingController.value.text,
                  ));
                }

                if (isAdded) {
                  // Close the Bottom Sheet
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
