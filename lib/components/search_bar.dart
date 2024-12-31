import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  const AppSearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      shadowColor: const WidgetStatePropertyAll(Colors.transparent),
      backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
      ),
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.search),
      ),
      hintText: hintText,
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      trailing: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(CupertinoIcons.clear),
        )
      ],
    );
  }
}
