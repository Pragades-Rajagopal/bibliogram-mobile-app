import 'package:flutter/material.dart';

class MiniButton extends StatefulWidget {
  final void Function() onPressed;
  final bool loadingIndicatorToggle;
  const MiniButton({
    super.key,
    required this.onPressed,
    required this.loadingIndicatorToggle,
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
        backgroundColor: Theme.of(context).colorScheme.primary,
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
              Icons.arrow_forward_outlined,
              size: 32.0,
              color: Theme.of(context).colorScheme.surface,
            ),
    );
  }
}
