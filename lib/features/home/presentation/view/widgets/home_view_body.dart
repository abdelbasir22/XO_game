import 'package:flutter/material.dart';
import 'package:x_o_game_app/core/utils/app_color.dart';
import 'package:x_o_game_app/features/play_vs_computer/presentation/view/play_vs_computer_view.dart';
import 'package:x_o_game_app/features/play_vs_friend/presentation/view/play_vs_friend_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
            AppColors.tertiaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              'XO GAME',
              style: TextStyle(
                fontSize: 60,
                fontFamily: 'BungeeShade',
                color: AppColors.blue,
              ),
            ),
            const Text(
              'TIC TAC TOE',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.wihte,
                fontFamily: 'PressStart2P',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 175,
              backgroundColor: AppColors.darkBlue,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/x_o.png',
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PlayVsFriendView(),
                  ),
                );
              },
              style: const ButtonStyle(
                fixedSize: WidgetStatePropertyAll(
                  Size(300, 55),
                ),
              ),
              child: const Text(
                'Play VS Friend',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'PressStart2P',
                    color: AppColors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PlayVsComputerView(),
                  ),
                );
              },
              style: const ButtonStyle(
                fixedSize: WidgetStatePropertyAll(
                  Size(300, 55),
                ),
              ),
              child: const Text(
                'Play VS Computer',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'PressStart2P',
                    color: AppColors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
