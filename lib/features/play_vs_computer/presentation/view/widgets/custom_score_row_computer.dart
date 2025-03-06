import 'package:flutter/material.dart';
import 'package:x_o_game_app/core/widgets/draw_container.dart';
import 'package:x_o_game_app/core/widgets/score_container.dart';

import '../../../../../core/utils/app_color.dart';

class CoustomScoreRowComputer extends StatelessWidget {
  const CoustomScoreRowComputer({
    super.key,
    required this.xScore,
    required this.drawScore,
    required this.oScore,
  });

  final int xScore;
  final int drawScore;
  final int oScore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScoreContainer(
            player: 'X',
            score: xScore.toString(),
            color: AppColors.blue,
          ),
          DrawContainer(
            draw: 'Draw:$drawScore',
          ),
          ScoreContainer(
            player: 'O',
            score: oScore.toString(),
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
