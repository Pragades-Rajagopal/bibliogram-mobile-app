import 'package:bibliogram/components/appbar.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  final String appBarTitle;
  final List<String> tabNames;
  final List<Widget> tabPages;
  const AppTabBar({
    super.key,
    required this.appBarTitle,
    required this.tabNames,
    required this.tabPages,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabNames.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const MyAppBar(
                title: 'My Activities',
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          isScrollable: true,
                          splashFactory: NoSplash.splashFactory,
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          labelColor: Theme.of(context).colorScheme.primary,
                          labelStyle: const TextStyle(fontSize: 22),
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.secondary,
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          indicatorWeight: 1,
                          labelPadding: const EdgeInsets.only(
                              top: 12, bottom: 8, right: 32),
                          dividerColor: Colors.transparent,
                          tabs:
                              tabNames.map((name) => Tab(text: name)).toList(),
                        )
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: tabPages,
          ),
        ),
      ),
    );
  }
}
