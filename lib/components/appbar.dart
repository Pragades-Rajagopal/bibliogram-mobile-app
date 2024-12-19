import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int index;
  const MyAppBar({
    super.key,
    this.title = 'Bibliogram',
    this.index = -1,
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
      ), //FlexibleSpaceBar
      expandedHeight: 60,
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
      //IconButton
      actions: const <Widget>[], //<Widget>[]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
