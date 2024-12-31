import 'package:bibliogram/components/appbar.dart';
import 'package:bibliogram/components/comment_card.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/services/comments.dart';
import 'package:bibliogram/services/grams.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';

class GramInfoPage extends StatefulWidget {
  final String gramId;
  const GramInfoPage({
    super.key,
    required this.gramId,
  });

  @override
  State<GramInfoPage> createState() => _GramInfoState();
}

class _GramInfoState extends State<GramInfoPage> {
  final ScrollController scrollController = ScrollController();
  CommonWidgets commonWidgets = CommonWidgets();
  Map<String, dynamic> gramInfo = {};
  List commentsList = [];
  int totalComments = 0;
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
          .getGramById(widget.gramId);
      final commentsResponse =
          await CommentsApi(userData["token"], userData["id"])
              .getComments(widget.gramId, limit: _limit, offset: _offset);
      int localOffset = _offset + _limit;
      setState(() {
        gramInfo = response.data![0];
        commentsList.addAll(commentsResponse.data!);
        totalComments = commentsResponse.count!;
        _offset = localOffset;
        if (commentsResponse.data!.length < _limit) {
          _hasFeedData = false;
        }
        _showPageLoader = false;
      });
    } catch (e) {
      if (mounted) {
        commonWidgets.showSnackBar(context, 'Something went wrong',
            duration: 200);
      }
      setState(() => _showPageLoader = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 14.0);
    return Scaffold(
      body: _showPageLoader
          ? commonWidgets.pageLoadingIndicator(context)
          : CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                const MyAppBar(title: 'Gram Info'),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          commonWidgets.appTextSpan(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 20,
                            children: [
                              commonWidgets.appTextSpan(text: 'Gram about '),
                              commonWidgets.appTextSpan(
                                text: gramInfo["book"],
                                fontWeight: FontWeight.bold,
                              ),
                              commonWidgets.appTextSpan(text: ' by '),
                              commonWidgets.appTextSpan(
                                text: gramInfo["author"],
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        sizedBox,
                        Text(
                          gramInfo["gram"]!,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        sizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text(
                                  'From ${gramInfo["user"]}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              gramInfo["shortDate"],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverContainer(
                  text: totalComments <= 1
                      ? '$totalComments comment'
                      : '$totalComments comments',
                  color: Theme.of(context).colorScheme.secondary,
                ),
                AppSliverList(
                  data: commentsList,
                  itemBuilder: (context, item) {
                    return CommentCard(item: item);
                  },
                ),
                totalComments > 0
                    ? paginationFooter(context)
                    : const SliverContainer(
                        text: '',
                        color: Colors.transparent,
                        padding: EdgeInsets.only(bottom: 36))
              ], //<Widget>[]
            ),
    );
  }

  SliverContainer paginationFooter(BuildContext context) {
    return _hasFeedData
        ? SliverContainer(
            text: 'Getting comments for you...',
            color: Theme.of(context).colorScheme.tertiary,
            padding: const EdgeInsets.only(bottom: 36))
        : SliverContainer(
            text: 'That\'s it!',
            color: Theme.of(context).colorScheme.tertiary,
            padding: const EdgeInsets.only(bottom: 36));
  }
}
