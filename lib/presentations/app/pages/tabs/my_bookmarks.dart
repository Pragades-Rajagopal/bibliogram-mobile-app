import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/gram_card.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/presentations/app/pages/gram_info.dart';
import 'package:bibliogram/services/grams.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookmarksPage extends StatefulWidget {
  const MyBookmarksPage({
    super.key,
  });

  @override
  State<MyBookmarksPage> createState() => _GramsPageState();
}

class _GramsPageState extends State<MyBookmarksPage> {
  final ScrollController scrollController = ScrollController();
  List gramBookmarks = [];
  // Pagination variables
  bool _showPageLoader = true;

  @override
  void initState() {
    super.initState();
    initAsyncMethods();
  }

  void initAsyncMethods() async {
    try {
      Map<String, dynamic> userData = await UserToken().getTokenData();
      final response = await GramsApi(userData["token"], userData["id"])
          .getGramBookmarksByQuery(userData["id"]);
      setState(() {
        gramBookmarks.addAll(response.data!);
        _showPageLoader = false;
      });
    } catch (e) {
      if (mounted) {
        CommonWidgets()
            .showSnackBar(context, 'Something went wrong', duration: 200);
      }
      setState(() => _showPageLoader = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showPageLoader
        ? CommonWidgets().pageLoadingIndicator(context)
        : CustomScrollView(
            // controller: scrollController,
            slivers: <Widget>[
              gramBookmarks.isEmpty
                  ? SliverContainer(
                      text: 'No grams bookmarked yet!',
                      color: Theme.of(context).colorScheme.tertiary,
                      padding: const EdgeInsets.only(top: 20),
                    )
                  : AppSliverList(
                      data: gramBookmarks,
                      itemBuilder: (context, item) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => GramInfoPage(gramId: item["gramId"]));
                          },
                          child: GramCard(
                            item: item,
                            displayMaxLines: 5,
                          ),
                        );
                      },
                    ),
              const SliverToBoxAdapter(child: SizedBox(height: 36))
            ], //<Widget>[]
          ); //CustonScrollView
  }
}
