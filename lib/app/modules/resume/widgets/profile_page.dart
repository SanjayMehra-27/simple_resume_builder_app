import 'package:flutter/material.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../widgets/buttons/primary/primary_button.dart';

class ProfilePage extends StatelessWidget {
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/profile_avatar.png'),
                      ),
                    ),
                    // Name
                    const PrimaryTextField(
                      hintText: 'e.g. John Doe',
                      labelText: 'Your Name',
                    ),
                    // Designation
                    const SizedBox(height: 20),
                    const PrimaryTextField(
                      hintText: 'e.g. Software Engineer',
                      labelText: 'Your Designation',
                    ),
                    // Your City
                    const SizedBox(height: 20),
                    const PrimaryTextField(
                      hintText: 'e.g. New York',
                      labelText: 'Your City',
                    ),

                    // Save Button
                    Expanded(child: SizedBox()),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Save',
                      onPressed: () {},
                    ),
                  ]),
            ),
          )

          // Save Button
          // const SizedBox(height: 20),
          // Container(
          //   height: 50,
          //   width: 300,
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: const Center(
          //     child: Text(
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
