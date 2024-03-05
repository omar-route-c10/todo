import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({
    required this.onPressed,
    required this.child,
  });

  VoidCallback onPressed;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: child,
    );
  }
}
