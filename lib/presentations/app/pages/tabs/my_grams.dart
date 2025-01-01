import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/gram_card.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/presentations/app/pages/gram_info.dart';
import 'package:bibliogram/services/grams.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGramsPage extends StatefulWidget {
  const MyGramsPage({
    super.key,
  });

  @override
  State<MyGramsPage> createState() => _GramsPageState();
}

class _GramsPageState extends State<MyGramsPage> {
  final ScrollController scrollController = ScrollController();
  List globalGrams = [];
  // Pagination variables
  final int _limit = 999999999;
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
          .getGramsByQuery(userData["id"], "userId", limit: _limit, offset: 0);
      setState(() {
        globalGrams.addAll(response.data!);
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
              globalGrams.isEmpty
                  ? SliverContainer(
                      text: 'No grams posted yet!',
                      color: Theme.of(context).colorScheme.tertiary,
                    )
                  : AppSliverList(
                      data: globalGrams,
                      itemBuilder: (context, item) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => GramInfoPage(gramId: item["id"]));
                          },
                          child: GramCard(
                            item: item,
                            displayMaxLines: 3,
                            showPrivateBadge: true,
                          ),
                        );
                      },
                    ),
              const SliverToBoxAdapter(child: SizedBox(height: 36))
            ], //<Widget>[]
          ); //CustonScrollView
  }
}
