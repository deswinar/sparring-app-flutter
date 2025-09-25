import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final String assetPath;

  const AppLoader({
    super.key,
    this.size = 150,
    this.assetPath = 'assets/lottie/loading-football.json',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Lottie.asset(
          assetPath,
          fit: BoxFit.contain,
          repeat: true,
        ),
      ),
    );
  }
}
