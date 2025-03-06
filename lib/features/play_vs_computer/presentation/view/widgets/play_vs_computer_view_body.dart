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
  List<String> grid = List.filled(9, '');
  bool isPlay = true, isWin = false;
  String winPlayer = '';
  int xScore = 0, oScore = 0, drawScore = 0;

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
    });
  }

  Timer? timer;
  void startTimer(bool computer) {
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

  int minimax(List<String> board, int depth, bool isMaximizing) {
    String result = getWinner();
    if (result == 'O') {
      return 1;
    } else if (result == 'X') {
      return -1;
    } else if (result == 'Draw') {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'O';
          int score = minimax(board, depth + 1, false);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'X';
          int score = minimax(board, depth + 1, true);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  void playComputer() {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < grid.length; i++) {
      if (grid[i] == '') {
        grid[i] = 'O';
        int score = minimax(grid, 0, false);
        grid[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    if (bestMove != -1) {
      grid[bestMove] = 'O';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.secondaryColor),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
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
                    'VS Computer',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontFamily: 'BungeeShade',
                      color: AppColors.white,
                    ),
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
                    icon: Icon(
                      Icons.restart_alt,
                      size: screenWidth * 0.08,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              CoustomScoreRowComputer(
                xScore: xScore,
                drawScore: drawScore,
                oScore: oScore,
              ),
              Text(
                "Now it's X turn",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontFamily: 'PressStart2P',
                  color: AppColors.liteColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: screenHeight * 0.5,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                    ),
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
                              color: AppColors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              grid[index],
                              style: TextStyle(
                                fontSize: screenWidth * 0.1,
                                fontFamily: 'PressStart2P',
                                color: AppColors.white,
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
