import 'package:flutter/material.dart';
import 'package:x_o_game_app/core/widgets/custom_elevation_button.dart';

import '../utils/app_color.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.onPress,
  });

  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'End Game',
        style: TextStyle(color: AppColors.secondaryColor),
      ),
      content: const Text(
        'Are you sure you want to end the game ?',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        CustomElevationButton(
          text: 'Yes',
          backgroundColor: AppColors.red,
          onPressed: onPress,
        ),
        CustomElevationButton(
          text: 'No',
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
