import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';

class LanguagesPage extends StatelessWidget {
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
                ),
                const SizedBox(height: 20),
                // Proficiency Level [Beginner, Intermediate, Advanced] [Selectable Chips]
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Chip(
                      label: const Text('Beginner'),
                      backgroundColor: Colors.green,
                      labelStyle: const TextStyle(color: Colors.white),
                      elevation: 0.1,
                    ),
                    Chip(
                      label: const Text('Intermediate'),
                      backgroundColor: Colors.grey[400],
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: const Text('Advanced'),
                      backgroundColor: Colors.grey[400],
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Add Languages',
                  color: Colors.green,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // Go back to the previous page
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 20),
                // Languages List
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: const Text('English'),
                        subtitle: const Text('Advanced'),
                        trailing: IconButton(
                          onPressed: () {
                            // Delete Languages
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
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

class AddLanguagesBottomsheet extends StatelessWidget {
  const AddLanguagesBottomsheet({
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
            'Add Languages',
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
              // Save Languages
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
