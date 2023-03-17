import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/resume_controller.dart';

class ResumeView extends GetView<ResumeController> {
  const ResumeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Your Resume',
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.person_add,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please add your details to see your resume.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
