import 'package:flutter/material.dart';

class SliverContainer extends StatelessWidget {
  final String text;
  final Color color;
  final EdgeInsets? padding;
  const SliverContainer({
    super.key,
    required this.text,
    required this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
