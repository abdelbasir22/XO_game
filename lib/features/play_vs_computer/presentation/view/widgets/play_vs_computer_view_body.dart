import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:x_o_game_app/core/widgets/custom_alert_dialog.dart';
import 'package:x_o_game_app/features/home/presentation/view/home_view.dart';
import 'package:x_o_game_app/features/play_vs_computer/presentation/view/widgets/custom_score_row_computer.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/widgets/custom_score_container.dart';

class PlayVsComputerViewBody extends StatefulWidget {
  const PlayVsComputerViewBody({super.key});

  @override
  State<PlayVsComputerViewBody> createState() => _PlayVsComputerViewBodyState();
}

class _PlayVsComputerViewBodyState extends State<PlayVsComputerViewBody> {
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
  String winPlayer = '';
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
  startTimer(bool computer) {
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
      if (computer) {
        playComputer();
      }
      timer.cancel();
    });
  }

  // computer play algo
  playComputer() {
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

    // o win
    for (var i = 0; i < winIndex.length; i++) {
      String a = grid[winIndex[i][0]];
      String b = grid[winIndex[i][1]];
      String c = grid[winIndex[i][2]];
      if (a == b && a == 'O' && c == '') {
        grid[winIndex[i][2]] = 'O';
        return;
      }
      if (a == c && a == 'O' && b == '') {
        grid[winIndex[i][1]] = 'O';
        return;
      }
      if (c == b && b == 'O' && a == '') {
        grid[winIndex[i][0]] = 'O';
        return;
      }
    }

    // stop x
    for (var i = 0; i < winIndex.length; i++) {
      String a = grid[winIndex[i][0]];
      String b = grid[winIndex[i][1]];
      String c = grid[winIndex[i][2]];
      if (a == b && a == 'X' && c == '') {
        grid[winIndex[i][2]] = 'O';
        return;
      }
      if (a == c && a == 'X' && b == '') {
        grid[winIndex[i][1]] = 'O';
        return;
      }
      if (c == b && b == 'X' && a == '') {
        grid[winIndex[i][0]] = 'O';
        return;
      }
    }
    //play any way
    List indexs = [0, 1, 2, 3, 4, 5, 6, 7, 8];
    indexs.shuffle(Random());
    for (var i = 0; i < grid.length; i++) {
      if (grid[indexs[i]] == '') {
        grid[indexs[i]] = 'O';
        return;
      }
    }
  }

  void delayedPlayComputer() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        playComputer();
        winPlayer = getWinner();
        if (winPlayer == 'O') {
          oScore++;
          startTimer(true);
        } else if (winPlayer == 'Draw') {
          drawScore++;
          startTimer(true);
        }
      });
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
                    'VS Computer',
                    style: TextStyle(
                        fontSize: 30,
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
              CoustomScoreRowComputer(
                xScore: xScore,
                drawScore: drawScore,
                oScore: oScore,
              ),
              const Text(
                "Now it's X turn",
                style: TextStyle(
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
                              grid[index] = 'X';
                              winPlayer = getWinner();
                              if (winPlayer == 'X') {
                                xScore++;
                                startTimer(false);
                              } else if (winPlayer == 'Draw') {
                                drawScore++;
                                startTimer(false);
                              } else {
                                delayedPlayComputer();
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
