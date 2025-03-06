import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CustomElevationButton extends StatelessWidget {
  const CustomElevationButton({
    super.key,
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
  });
  final Color backgroundColor;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: AppColors.white),
      ),
    );
  }
}
