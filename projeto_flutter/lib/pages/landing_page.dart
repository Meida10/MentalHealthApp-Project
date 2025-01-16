import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/LogotipoSaudeMental.png',
                height: 300,
                width: 300,
              ),
              Image.asset(
                'assets/image.png',
                height: 300,
                width: 300,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
