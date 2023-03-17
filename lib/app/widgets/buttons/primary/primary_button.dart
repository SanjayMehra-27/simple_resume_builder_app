import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.textStyle,
    this.elevation,
    this.borderRadius,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? elevation;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color ?? Colors.black,
        onPrimary: textColor ?? Colors.white,
        elevation: elevation ?? 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
      ),
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
