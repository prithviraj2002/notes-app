import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:note_making_app/screens/home-screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: const Text(
          'Notes App',
          style: TextStyle(
            fontSize: 35
          ),
        ),
        splashTransition: SplashTransition.slideTransition,
        nextScreen: const HomeScreen()
    );
  }
}
