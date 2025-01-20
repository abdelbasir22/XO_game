import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CustomScoreContainer extends StatelessWidget {
  const CustomScoreContainer({
    super.key,
    required this.winPlayer,
  });

  final String winPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.darkColor),
          child: Center(
            child: Text(
              winPlayer == 'Draw' ? 'Draw' : '$winPlayer is win',
              style: const TextStyle(
                  fontSize: 60,
                  color: AppColors.liteColor,
                  fontFamily: 'BungeeShade'),
            ),
          ),
        ),
      ),
    );
  }
}
