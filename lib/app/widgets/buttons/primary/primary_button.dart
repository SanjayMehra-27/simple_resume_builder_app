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
    this.icon,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? elevation;
  final double? borderRadius;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          icon: icon ?? const SizedBox(),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.black,
            onPrimary: textColor ?? Colors.white,
            elevation: elevation ?? 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
            maximumSize: const Size(double.infinity, 100),
          ),
          label: Text(
            text,
            style: textStyle ??
                const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
