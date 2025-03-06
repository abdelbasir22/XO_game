import 'package:flutter/material.dart';
import 'package:x_o_game_app/features/player_mode/presentation/view/widgets/player_mode_view_body.dart';

class PlayerModeView extends StatelessWidget {
  const PlayerModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PlayerModeViewBody(),
    );
  }
}
