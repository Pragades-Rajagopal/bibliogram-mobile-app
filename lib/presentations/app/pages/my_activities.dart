import 'package:bibliogram/components/tab_bar.dart';
import 'package:bibliogram/presentations/app/pages/tabs/my_bookmarks.dart';
import 'package:bibliogram/presentations/app/pages/tabs/my_comments.dart';
import 'package:bibliogram/presentations/app/pages/tabs/my_grams.dart';
import 'package:flutter/material.dart';

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({super.key});

  @override
  State<MyActivitiesPage> createState() => _MyGramsPageState();
}

class _MyGramsPageState extends State<MyActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppTabBar(
        appBarTitle: 'My Grams',
        tabNames: [
          'Grams',
          'Bookmarks',
          'Comments',
        ],
        tabPages: [
          MyGramsPage(),
          MyBookmarksPage(),
          MyCommentsPage(),
        ],
      ),
    );
  }
}
