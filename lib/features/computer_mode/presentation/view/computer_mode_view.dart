import 'package:flutter/material.dart';
import 'package:x_o_game_app/features/computer_mode/presentation/view/widgets/computer_mode_view_body.dart';

class ComputerModeView extends StatelessWidget {
  const ComputerModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ComputerModeViewBody(),
    );
  }
}
