import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontStyle fontStyle;
  final int maxLines;
  final CrossAxisAlignment crossAxisAlignment;
  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 6,
    this.fontSize = 18.0,
    this.fontStyle = FontStyle.normal,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  Icon expandIcon = const Icon(CupertinoIcons.chevron_compact_down);

  void onPress() {
    setState(() {
      _isExpanded = !_isExpanded;
      expandIcon = _isExpanded
          ? const Icon(CupertinoIcons.chevron_compact_up)
          : const Icon(CupertinoIcons.chevron_compact_down);
    });
  }

  int _calculateLines(String text, double width) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style:
            TextStyle(fontSize: widget.fontSize, fontStyle: widget.fontStyle),
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width);
    return (textPainter.size.height /
            const TextStyle(fontSize: 18.0).fontSize!.toInt())
        .round();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final totalLines = _calculateLines(widget.text, screenWidth);

    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).colorScheme.secondary,
            fontStyle: widget.fontStyle,
          ),
          maxLines: _isExpanded ? null : widget.maxLines,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
        ),
        if (totalLines > widget.maxLines)
          IconButton(
            onPressed: onPress,
            icon: _isExpanded ? expandIcon : expandIcon,
            style: ButtonStyle(
              iconColor:
                  WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
              iconSize: const WidgetStatePropertyAll(28),
              splashFactory: NoSplash.splashFactory,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            ),
          )
        else
          Container(),
      ],
    );
  }
}
