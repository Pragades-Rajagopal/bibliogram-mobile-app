import 'package:flutter/material.dart';

class AppSliverList extends StatelessWidget {
  final Widget Function(BuildContext context, Map<String, dynamic> item)
      itemBuilder;
  final List data;
  const AppSliverList({
    super.key,
    required this.itemBuilder,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: data.length,
          (context, index) {
            return itemBuilder(context, data[index]);
          }, //SliverChildBuildDelegate
        ),
      ),
    );
  }
}
