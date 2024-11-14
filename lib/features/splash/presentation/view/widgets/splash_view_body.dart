import 'package:flutter/material.dart';
import 'package:x_o_game_app/features/home/presentation/view/home_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(
            radius: 150,
            child: ClipOval(
              child: Image.asset(
                'assets/images/x_o_game.png',
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Play XO',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 45,
            fontFamily: 'BungeeShade',
          ),
        ),
      ],
    );
  }
}
