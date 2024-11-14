import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class DrawContainer extends StatelessWidget {
  const DrawContainer({
    super.key,
    required this.draw,
  });
  final String draw;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColor.wihte,
      ),
      child: Center(
        child: Text(
          draw,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: 'PressStart2P',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
