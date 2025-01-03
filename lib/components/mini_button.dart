import 'package:flutter/material.dart';

class MiniButton extends StatefulWidget {
  final void Function() onPressed;
  final bool loadingIndicatorToggle;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  const MiniButton({
    super.key,
    required this.onPressed,
    required this.loadingIndicatorToggle,
    required this.backgroundColor,
    required this.iconColor,
    this.icon = Icons.arrow_forward_outlined,
    this.iconSize = 32.0,
  });

  @override
  State<MiniButton> createState() => _MiniButtonState();
}

class _MiniButtonState extends State<MiniButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        overlayColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        minimumSize: const Size(60, 60),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
      child: widget.loadingIndicatorToggle
          ? Container(
              height: 30,
              width: 32,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.surface,
              ),
            )
          : Icon(
              widget.icon,
              size: widget.iconSize,
              color: widget.iconColor,
            ),
    );
  }
}
