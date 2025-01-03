import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidgets {
  void showSnackBar(BuildContext context, String message, {duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.surfaceBright,
        ),
      ),
    );
  }

  Widget pageLoadingIndicator(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: const Padding(
        padding: EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomNavbarItems() {
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.circle_grid_hex),
        activeIcon: Icon(CupertinoIcons.circle_grid_hex_fill),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined),
        activeIcon: Icon(Icons.explore_rounded),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.book),
        activeIcon: Icon(CupertinoIcons.book_fill),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.tray_full),
        activeIcon: Icon(CupertinoIcons.tray_full_fill),
        label: '',
      ),
    ];
  }

  TextSpan appTextSpan(
      {String? text,
      List<TextSpan> children = const [],
      double fontSize = 20,
      FontWeight fontWeight = FontWeight.normal,
      Color? color}) {
    return TextSpan(
      text: text,
      children: children,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
