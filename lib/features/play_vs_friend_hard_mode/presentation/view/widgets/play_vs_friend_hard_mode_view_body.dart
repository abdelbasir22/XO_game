import 'dart:async';

import 'package:flutter/material.dart';
import 'package:x_o_game_app/core/utils/app_color.dart';
import 'package:x_o_game_app/core/widgets/custom_score_container.dart';
import 'package:x_o_game_app/features/play_vs_friend/presentation/view/widgets/custom_score_row.dart';

import '../../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../home/presentation/view/home_view.dart';

class PlayVsFriendHardModeViewBody extends StatefulWidget {
  const PlayVsFriendHardModeViewBody({super.key});

  @override
  State<PlayVsFriendHardModeViewBody> createState() =>
      _PlayVsFrindViewBodyState();
}

class _PlayVsFrindViewBodyState extends State<PlayVsFriendHardModeViewBody> {
  List<String> grid = List.filled(9, '');
  List<int> xMoves = [];
  List<int> oMoves = [];
  bool isPlay = true, isWin = false;
  String frist = 'X', winPlayer = '';
  int xScore = 0, oScore = 0, drawScore = 0;
  int? removedIndex;

  String getWinner() {
    List<List<int>> winIndex = [
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

  void clearGrid() {
    setState(() {
      grid = List.filled(9, '');
      xMoves.clear();
      oMoves.clear();
      removedIndex = null;
    });
  }

  Timer? timer;
  void startTimer() {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.secondaryColor),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.05,
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
                    icon: Icon(
                      Icons.close,
                      size: screenWidth * 0.08,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'VS Friend',
                    style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontFamily: 'BungeeShade',
                        color: AppColors.white),
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
                    icon: Icon(
                      Icons.restart_alt,
                      size: screenWidth * .08,
                      color: AppColors.white,
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
                style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontFamily: 'PressStart2P',
                    color: AppColors.liteColor),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: screenHeight * 0.5,
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
                                if (xMoves.length == 3) {
                                  removedIndex = xMoves.removeAt(0);
                                  grid[removedIndex!] = '';
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    setState(() {
                                      removedIndex = null;
                                    });
                                  });
                                }
                                grid[index] = 'X';
                                xMoves.add(index);
                              } else {
                                if (oMoves.length == 3) {
                                  removedIndex = oMoves.removeAt(0);
                                  grid[removedIndex!] = '';
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    setState(() {
                                      removedIndex = null;
                                    });
                                  });
                                }
                                grid[index] = 'O';
                                oMoves.add(index);
                              }

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
                                frist = frist == 'X' ? 'O' : 'X';
                              }
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: AppColors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              grid[index],
                              style: TextStyle(
                                fontSize: screenWidth * 0.1,
                                fontFamily: 'PressStart2P',
                                color: (frist == 'X' &&
                                            xMoves.length == 3 &&
                                            index == xMoves.first) ||
                                        (frist == "O" &&
                                            oMoves.length == 3 &&
                                            index == oMoves.first)
                                    ? AppColors.liteColor
                                    : AppColors.white,
                              ),
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
