import 'package:bibliogram/components/gram_card.dart';
import 'package:flutter/material.dart';

class AppSliverList extends StatelessWidget {
  final List data;
  const AppSliverList({
    super.key,
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
            return GramCard(data: data[index]);
          }, //SliverChildBuildDelegate
        ),
      ),
    );
  }
}
