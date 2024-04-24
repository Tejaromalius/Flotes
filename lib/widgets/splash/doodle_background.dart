import 'package:flutter/material.dart';

class DoodleBackground extends StatelessWidget {
  const DoodleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        "assets/images/background_doodles.png",
        repeat: ImageRepeat.repeat,
        opacity: const AlwaysStoppedAnimation(0.05),
      ),
    );
  }
}
