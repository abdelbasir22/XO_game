import 'package:flutter/material.dart';
import 'package:x_o_game_app/features/play_vs_friend/presentation/view/play_vs_friend_view.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../play_vs_friend_hard_mode/presentation/view/play_vs_friend_hard_mode_view.dart';

class PlayerModeViewBody extends StatelessWidget {
  const PlayerModeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
              size: screenWidth * 0.08,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'Select Mode',
                  style: TextStyle(
                    fontSize: screenWidth * 0.11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontFamily: 'BungeeShade',
                  ),
                ),
                SizedBox(height: screenHeight * 0.25),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayVsFriendView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.thumb_up,
                          color: AppColors.white, size: screenWidth * 0.07),
                      SizedBox(width: screenWidth * 0.03),
                      Text(
                        'Normal Mode',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: AppColors.white,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayVsFriendHardModeView(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.whatshot,
                          color: AppColors.white, size: screenWidth * 0.07),
                      SizedBox(width: screenWidth * 0.03),
                      Text(
                        'Hard Mode',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          color: AppColors.white,
                          fontFamily: 'PressStart2P',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
