import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final PreferredSizeWidget? bottomWidget;
  final double? height;
  final EdgeInsets? titlePadding;
  const MyAppBar({
    super.key,
    this.title = 'Bibliogram',
    this.actions = const [],
    this.bottomWidget,
    this.height = 60,
    this.titlePadding,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: false,
      pinned: false,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16.0,
          ), //TextStyle
        ), //Text
        titlePadding: titlePadding,
      ), //FlexibleSpaceBar
      expandedHeight: height,
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      //IconButton
      actions: actions, //<Widget>[]
      bottom: bottomWidget,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
