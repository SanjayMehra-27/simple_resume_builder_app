import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

import '../../../model/resume_section/resume_section.dart';
import '../../../widgets/buttons/primary/primary_button.dart';

class AddDetailsView extends StatelessWidget {
  const AddDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Add your details here...',
            style: AppTextStyleConst.heading,
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Close the Add Details page
              Get.back();
            },
            icon: const Icon(Icons.close, color: Colors.black, size: 30),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // List of section [Profile, Education, Experience, Skills, Projects, Contact, Languages]
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: resumeSections.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          resumeSections[index].icon,
                          color: Colors.black,
                        ),
                        title: Text(
                          resumeSections[index].title,
                          style: AppTextStyleConst.title2,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                        onTap: () {
                          resumeSections[index].onTap?.call();
                        },
                      );
                    },
                  ),
                ),
              ),

              // Info text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'You can change the order of the sections by dragging and dropping them.',
                        style: AppTextStyleConst.subtitle,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Save button
              PrimaryButton(
                text: 'Done',
                onPressed: () {
                  // Close the Add Details page
                  Get.back();
                },
              ),
            ],
          ),
        ));
  }
}
