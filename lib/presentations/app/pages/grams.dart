import 'package:bibliogram/components/appbar.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/gram_card.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/services/grams.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';

class GramsPage extends StatefulWidget {
  const GramsPage({super.key});

  @override
  State<GramsPage> createState() => _GramsPageState();
}

class _GramsPageState extends State<GramsPage> {
  final ScrollController scrollController = ScrollController();
  List globalGrams = [];
  // Pagination variables
  final int _limit = 10;
  int _offset = 0;
  bool _hasFeedData = true;
  bool _showPageLoader = true;

  @override
  void initState() {
    super.initState();
    initAsyncMethods();
    pagination();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void pagination() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (_hasFeedData) {
          initAsyncMethods();
        }
      }
    });
  }

  void initAsyncMethods() async {
    try {
      Map<String, dynamic> userData = await UserToken().getTokenData();
      final response = await GramsApi(userData["token"], userData["id"])
          .getGlobalGrams(_limit, _offset);
      int localOffset = _offset + _limit;
      setState(() {
        globalGrams.addAll(response.data!);
        _offset = localOffset;
        if (response.data!.length < _limit) {
          _hasFeedData = false;
        }
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
    return Scaffold(
      body: _showPageLoader
          ? CommonWidgets().pageLoadingIndicator(context)
          : CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                const MyAppBar(title: 'Grams'),
                globalGrams.isEmpty
                    ? SliverContainer(
                        text: 'No grams posted yet!',
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                    : AppSliverList(
                        data: globalGrams,
                        itemBuilder: (context, item) {
                          return GramCard(item: item);
                        },
                      ),
                _hasFeedData
                    ? SliverContainer(
                        text: 'Crunching grams for you...',
                        color: Theme.of(context).colorScheme.tertiary,
                        padding: const EdgeInsets.only(bottom: 36))
                    : SliverContainer(
                        text: 'That\'s it!',
                        color: Theme.of(context).colorScheme.tertiary,
                        padding: const EdgeInsets.only(bottom: 36))
              ], //<Widget>[]
            ), //CustonScrollView
    ); //MaterialApp
  }
}
