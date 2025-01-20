import 'dart:async';

import 'package:flutter/material.dart';
import 'package:x_o_game_app/core/utils/app_color.dart';
import 'package:x_o_game_app/core/widgets/custom_score_container.dart';
import 'package:x_o_game_app/features/play_vs_friend/presentation/view/widgets/custom_score_row.dart';

import '../../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../home/presentation/view/home_view.dart';

class PlayVsFrindViewBody extends StatefulWidget {
  const PlayVsFrindViewBody({super.key});

  @override
  State<PlayVsFrindViewBody> createState() => _PlayVsFrindViewBodyState();
}

class _PlayVsFrindViewBodyState extends State<PlayVsFrindViewBody> {
  List grid = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  bool isPlay = true, isWin = false;
  String frist = 'X', winPlayer = '';
  int xScore = 0, oScore = 0, drawScore = 0;
  getWinner() {
    List winIndex = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var i = 0; i < winIndex.length; i++) {
      String a = grid[winIndex[i][0]];
      String b = grid[winIndex[i][1]];
      String c = grid[winIndex[i][2]];
      if (a == b && b == c && a != '') {
        return a;
      }
    }
    if (!grid.contains('')) {
      return 'Draw';
    }
    return '';
  }

  clearGrid() {
    setState(() {
      for (var i = 0; i < grid.length; i++) {
        grid[i] = '';
      }
    });
  }

  Timer? timer;
  startTimer() {
    setState(() {
      isPlay = false;
      isWin = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      clearGrid();
      setState(() {
        isPlay = true;
        isWin = false;
      });
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.secondaryColor),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          onPress: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 35,
                      color: AppColors.wihte,
                    ),
                  ),
                  const Text(
                    'VS Friend',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'BungeeShade',
                        color: AppColors.wihte),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        clearGrid();
                        xScore = 0;
                        oScore = 0;
                        drawScore = 0;
                        frist = 'X';
                      });
                    },
                    icon: const Icon(
                      Icons.restart_alt,
                      size: 35,
                      color: AppColors.wihte,
                    ),
                  ),
                ],
              ),
              CoustomScoreRow(
                xScore: xScore,
                frist: frist,
                drawScore: drawScore,
                oScore: oScore,
              ),
              Text(
                "Now it's $frist turn",
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'PressStart2P',
                    color: AppColors.liteColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0.0,
                            crossAxisSpacing: 0.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (grid[index] == '' && isPlay) {
                              if (frist == 'X') {
                                grid[index] = 'X';
                                winPlayer = getWinner();
                                if (winPlayer == 'X') {
                                  xScore++;
                                  frist = 'X';
                                  startTimer();
                                } else if (winPlayer == 'O') {
                                  oScore++;
                                  frist = 'O';
                                  startTimer();
                                } else if (winPlayer == 'Draw') {
                                  drawScore++;
                                  startTimer();
                                } else {
                                  frist = 'O';
                                }
                              } else {
                                grid[index] = 'O';
                                winPlayer = getWinner();
                                if (winPlayer == 'X') {
                                  xScore++;
                                  frist = 'X';
                                  startTimer();
                                } else if (winPlayer == 'O') {
                                  oScore++;
                                  frist = 'O';
                                  startTimer();
                                } else if (winPlayer == 'Draw') {
                                  drawScore++;
                                  startTimer();
                                } else {
                                  frist = 'X';
                                }
                              }
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              grid[index],
                              style: const TextStyle(
                                  fontSize: 45,
                                  fontFamily: 'PressStart2P',
                                  color: AppColors.wihte),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: grid.length,
                  ),
                ),
              ),
            ],
          ),
          if (isWin == true) CustomScoreContainer(winPlayer: winPlayer),
        ],
      ),
    );
  }
}
