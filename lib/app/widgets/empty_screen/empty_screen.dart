import 'package:flutter/material.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget({
    Key? key,
    this.text,
    this.description,
  }) : super(key: key);

  final String? text;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text ?? '',
            style: AppTextStyleConst.heading,
          ),
          const SizedBox(height: 10),
          Text(
            description ?? '',
            style: AppTextStyleConst.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
