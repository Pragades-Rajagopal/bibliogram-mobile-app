import 'package:flutter/material.dart';

class TextLinkButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final void Function() onPressed;
  const TextLinkButton({
    super.key,
    required this.text,
    this.fontSize = 18.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
