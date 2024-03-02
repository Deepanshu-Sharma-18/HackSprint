import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context,) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 116, 190, 250),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/airplane.png', 
                width: 200, 
                height: 200, 
              ),
              const SizedBox(height: 20),
              const Text(
                'Airplane',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
               

            ],
          ),
        ),
      ),
    );
  }
}