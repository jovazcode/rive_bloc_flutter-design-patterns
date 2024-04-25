import 'package:flutter/material.dart';

class LogoButton extends StatelessWidget {
  const LogoButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/images/logo.png', width: 24.0),
      onPressed: onPressed,
    );
  }
}
