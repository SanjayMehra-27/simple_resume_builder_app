import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../model/experience/experience_model.dart';
import '../../../widgets/buttons/primary/primary_button.dart';
import '../controllers/resume_controller.dart';

class ExperiencePage extends StatelessWidget {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Experience Card
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
                  // company name, duration, designation, summary
                  child: ListTile(
                    onLongPress: () {},
                    isThreeLine: true,
                    title: const Text(
                      'Software Engineer',
                      style: AppTextStyleConst.heading,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Google',
                          style: AppTextStyleConst.title2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Aug 2017 - Aug 2021',
                          style: AppTextStyleConst.subtitle,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Worked on Flutter, Firebase, and Google Cloud',
                          style: AppTextStyleConst.caption,
                        ),
                      ],
                    ),
                  ),
                ),

                // Add Experience Button
                const Expanded(child: SizedBox()),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Add Experience',
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Add Experience Bottom Sheet
                    showModalBottomSheet(
                      context: context,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 800,
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
              'Add Experience',
              style: AppTextStyleConst.heading,
            ),
            // Company Name, Designation, Duration, Summary
            const SizedBox(height: 20),
            const PrimaryTextField(
              hintText: 'e.g. Google',
              labelText: 'Company Name',
            ),
            const SizedBox(height: 20),
            const PrimaryTextField(
              hintText: 'e.g. Software Engineer',
              labelText: 'Designation',
            ),
            const SizedBox(height: 20),
            const PrimaryTextField(
              hintText: 'e.g. Aug 2017 - Aug 2021',
              labelText: 'Duration',
            ),
            const SizedBox(height: 20),
            const PrimaryTextField(
              hintText: 'e.g. Worked on Flutter, Firebase, and Google Cloud',
              labelText: 'Summary',
            ),
            PrimaryButton(
              text: 'Save',
              icon: const Icon(Icons.save),
              onPressed: () {
                // Save Experience
                controller.addExperienceSection(
                  ExperienceModel(
                    company: 'ABC Company',
                    designation: 'Software Engineer',
                    duration: '2019 - Present',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  // ExperienceModel(
                  //   company: 'XYZ Company',
                  //   designation: 'Software Engineer',
                  //   duration: '2018 - 2019',
                  //   description:
                  //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.controller,
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            labelText ?? 'Label',
            style: AppTextStyleConst.title,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText ?? '',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
          ),
        ),
      ],
    );
  }
}
