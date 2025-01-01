import 'package:bibliogram/components/appbar.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/gram_card.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/presentations/app/pages/gram_info.dart';
import 'package:bibliogram/services/books.dart';
import 'package:bibliogram/services/grams.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookInfoPage extends StatefulWidget {
  final String bookId;
  const BookInfoPage({super.key, required this.bookId});

  @override
  State<BookInfoPage> createState() => _BookInfoPageState();
}

class _BookInfoPageState extends State<BookInfoPage> {
  final ScrollController scrollController = ScrollController();
  CommonWidgets commonWidgets = CommonWidgets();
  Map<String, dynamic> bookinfo = {};
  List gramsList = [];
  int totalGrams = 0;
  // Pagination variables
  final int _limit = 20;
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
      final response = await BooksApi(userData["token"], userData["id"])
          .getBookById(widget.bookId);
      final gramsResponse = await GramsApi(userData["token"], userData["id"])
          .getGramsByQuery(widget.bookId, 'bookId',
              limit: _limit, offset: _offset);
      int localOffset = _offset + _limit;
      setState(() {
        bookinfo = response.data![0];
        gramsList.addAll(gramsResponse.data!);
        totalGrams = gramsResponse.count!;
        _offset = localOffset;
        if (gramsResponse.data!.length < _limit) {
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
                const MyAppBar(title: 'Book Info'),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text.rich(
                        //   commonWidgets.appTextSpan(
                        //     color: Theme.of(context).colorScheme.secondary,
                        //     fontSize: 20,
                        //     children: [
                        //       commonWidgets.appTextSpan(text: 'Gram about '),
                        //       commonWidgets.appTextSpan(
                        //         text: bookinfo["book"],
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //       commonWidgets.appTextSpan(text: ' by '),
                        //       commonWidgets.appTextSpan(
                        //         text: bookinfo["author"],
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // sizedBox,
                        Text(
                          bookinfo["name"]!,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        Text(
                          bookinfo["author"]!,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        sizedBox,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: Padding(
                        //         padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        //         child: Text(
                        //           'From ${bookinfo["user"]}',
                        //           style: TextStyle(
                        //             fontSize: 18.0,
                        //             color:
                        //                 Theme.of(context).colorScheme.secondary,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Text(
                        //       bookinfo["shortDate"],
                        //       style: TextStyle(
                        //         fontSize: 16.0,
                        //         color: Theme.of(context).colorScheme.secondary,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                SliverContainer(
                  text: totalGrams <= 1
                      ? '$totalGrams gram'
                      : '$totalGrams grams',
                  color: Theme.of(context).colorScheme.secondary,
                ),
                AppSliverList(
                  data: gramsList,
                  itemBuilder: (context, item) {
                    return GestureDetector(
                      onTap: () =>
                          Get.to(() => GramInfoPage(gramId: item["id"])),
                      child: GramCard(
                        item: item,
                        showBookMetadata: false,
                      ),
                    );
                  },
                ),
                totalGrams > 0
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
            text: 'Getting grams for you...',
            color: Theme.of(context).colorScheme.tertiary,
            padding: const EdgeInsets.only(bottom: 36))
        : SliverContainer(
            text: 'That\'s it!',
            color: Theme.of(context).colorScheme.tertiary,
            padding: const EdgeInsets.only(bottom: 36));
  }
}
