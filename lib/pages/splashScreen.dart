import 'dart:collection';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flightsky/pages/mapview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MapView()),
      );
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: Curves.ease,
                duration: const Duration(seconds: 3),
                builder: (BuildContext context, double opacity, Widget? child) {
                  return Opacity(
                      opacity: opacity,
                      child: Image.asset(
                        color: Colors.white,
                        'assets/flight.png',
                        height: 150,
                        width: 200,
                      ));
                }),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'SkyTrack India',
                  textStyle: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 100),
              displayFullTextOnTap: false,
              stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
