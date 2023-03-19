import 'package:flutter/material.dart';

import '../../../constants/text_style_const/text_style_const.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.controller,
    this.suffix,
    this.initialValue,
    this.maxLines,
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? initialValue;
  final int? maxLines;

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
          initialValue: initialValue,
          controller: initialValue == null ? controller : null,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
