import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({
    super.key,
    required this.player,
    required this.score,
    required this.color,
  });
  final String player, score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 130,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          width: 2,
          color: AppColor.black,
        ),
      ),
      child: Column(
        children: [
          Text(
            player,
            style: const TextStyle(
                fontSize: 60,
                fontFamily: 'BungeeShade',
                color: AppColor.darkColor),
          ),
          const Text(
            'SCORE',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'BungeeShade',
                color: AppColor.darkColor),
          ),
          Text(
            score,
            style: const TextStyle(
                fontSize: 30,
                fontFamily: 'PressStart2P',
                color: AppColor.darkColor),
          ),
        ],
      ),
    );
  }
}
