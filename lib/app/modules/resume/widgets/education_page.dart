import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../widgets/buttons/primary/primary_button.dart';

class EducationPage extends StatelessWidget {
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
                    title: const Text(
                      'Bachelor of Engineering',
                      style: AppTextStyleConst.heading,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'University of Engineering and Technology',
                          style: AppTextStyleConst.subtitle,
                        ),
                        Text(
                          'Aug 2017 - Aug 2021',
                          style: AppTextStyleConst.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      // Add Education
                    },
                  ),
                ),

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

class AddEducationBottomsheet extends StatelessWidget {
  const AddEducationBottomsheet({
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
            'Add Education',
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
              // Save Education
              Get.back();
            },
          ),
        ],
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
