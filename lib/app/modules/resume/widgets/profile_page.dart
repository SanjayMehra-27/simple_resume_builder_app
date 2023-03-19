import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../model/profile/profile_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';
import '../controllers/resume_controller.dart';

class ProfilePage extends GetView<ResumeController> {
  const ProfilePage({Key? key}) : super(key: key);

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
            title: const Text('Your Profile', style: AppTextStyleConst.heading),
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
            child: Center(
                child: Obx(
              () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/profile_avatar.png'),
                      ),
                    ),
                    // Name
                    PrimaryTextField(
                      initialValue: controller.profileSection.value.name,
                      hintText: 'e.g. John Doe',
                      labelText: 'Your Name',
                      controller: controller.nameTextEditingController.value,
                    ),
                    // Designation
                    const SizedBox(height: 20),
                    PrimaryTextField(
                      initialValue: controller.profileSection.value.designation,
                      hintText: 'e.g. Software Engineer',
                      labelText: 'Your Designation',
                      controller: controller.emailTextEditingController.value,
                    ),
                    // Email
                    const SizedBox(height: 20),
                    PrimaryTextField(
                        initialValue: controller.profileSection.value.email,
                        hintText: 'e.g. john@gmail.com',
                        labelText: 'Your Email',
                        controller:
                            controller.emailTextEditingController.value),
                    // Phone
                    const SizedBox(height: 20),
                    PrimaryTextField(
                        initialValue: controller.profileSection.value.phone,
                        hintText: 'e.g. +91 1234567890',
                        labelText: 'Your Phone',
                        controller:
                            controller.phoneTextEditingController.value),
                    // Your Address
                    const SizedBox(height: 20),
                    PrimaryTextField(
                      initialValue: controller.profileSection.value.address,
                      hintText: 'e.g. New York',
                      labelText: 'Your Address',
                      controller: controller.addressTextEditingController.value,
                    ),

                    // Save Button
                    const Expanded(child: SizedBox()),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Save',
                      icon: const Icon(Icons.save, color: Colors.white),
                      onPressed: () async {
                        bool isUpdate = false;
                        isUpdate = await controller.addOrUpdateProfileSection(
                          ProfileModel(
                            name:
                                controller.nameTextEditingController.value.text,
                            email: controller
                                .emailTextEditingController.value.text,
                            phone: controller
                                .phoneTextEditingController.value.text,
                            address: controller
                                .addressTextEditingController.value.text,
                            designation: controller
                                .designationTextEditingController.value.text,
                          ),
                        );
                        if (isUpdate) {
                          Get.back();
                        }
                      },
                    ),
                  ]),
            )),
          )),
    );
  }
}
