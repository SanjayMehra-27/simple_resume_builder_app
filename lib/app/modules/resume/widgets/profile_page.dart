import 'package:flutter/material.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../widgets/buttons/primary/primary_button.dart';
import '../../../widgets/text_field/primary/primary_text_field.dart';

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
                        radius: 50,
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
                    // Email
                    const SizedBox(height: 20),
                    const PrimaryTextField(
                      hintText: 'e.g. john@gmail.com',
                      labelText: 'Your Email',
                    ),
                    // Phone
                    const SizedBox(height: 20),
                    const PrimaryTextField(
                      hintText: 'e.g. +91 1234567890',
                      labelText: 'Your Phone',
                    ),
                    // Your Address
                    const SizedBox(height: 20),
                    const PrimaryTextField(
                      hintText: 'e.g. New York',
                      labelText: 'Your Address',
                    ),

                    // Save Button
                    const Expanded(child: SizedBox()),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Save',
                      icon: const Icon(Icons.save, color: Colors.white),
                      onPressed: () {},
                    ),
                  ]),
            ),
          )),
    );
  }
}
