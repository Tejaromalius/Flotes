import 'package:flutter/material.dart';

class LongPressableFloatingActionButton extends StatelessWidget {
  final Function(BuildContext) onLongPressed;
  final Function() onPressed;

  const LongPressableFloatingActionButton({
    required this.onLongPressed,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 60,
        minHeight: 60,
      ),
      child: GestureDetector(
        onLongPressStart: (details) => onLongPressed(context),
        child: FloatingActionButton(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: onPressed,
          child: Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
