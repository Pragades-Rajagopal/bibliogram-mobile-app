import 'package:bibliogram/components/appbar.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/presentations/app/pages/grams.dart';
import 'package:bibliogram/utils/themes.dart';
import 'package:flutter/material.dart';

class AppBasePage extends StatefulWidget {
  const AppBasePage({super.key});

  @override
  State<AppBasePage> createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage> {
  late PageController _pageController = PageController();
  var _currentIndex = 0;

  // App pages as widgets
  static final List<Widget> _widget = [
    const GramsPage(),
    const GramsPage(),
    const GramsPage(),
    const GramsPage(),
  ];

  // Titles
  static final List<String> _titles = [
    'Bibliogram',
    'Explore',
    'Wishlist',
    'Activities',
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = 0;
      _pageController = PageController(initialPage: _currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: _titles[_currentIndex]),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        allowImplicitScrolling: true,
        children: _widget,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textTheme: textTheme,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
          iconSize: 30.0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          items: CommonWidgets().bottomNavbarItems(),
        ),
      ),
    );
  }
}
