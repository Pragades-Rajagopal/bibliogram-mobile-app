import 'package:bibliogram/components/appbar.dart';
import 'package:bibliogram/components/book_card.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/search_bar.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/presentations/app/pages/book_info.dart';
import 'package:bibliogram/services/books.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBooksPage extends StatefulWidget {
  const TopBooksPage({super.key});

  @override
  State<TopBooksPage> createState() => _TopBooksState();
}

class _TopBooksState extends State<TopBooksPage> {
  List topBooksData = [];
  // State variables
  bool _showPageLoader = true;

  @override
  void initState() {
    super.initState();
    initAsyncMethods();
  }

  void initAsyncMethods() async {
    try {
      Map<String, dynamic> userData = await UserToken().getTokenData();
      final response =
          await BooksApi(userData["token"], userData["id"]).getTopBooks();
      setState(() {
        topBooksData.addAll(response.data!);
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
              slivers: [
                const MyAppBar(
                  title: 'Top Books',
                  height: 110,
                  titlePadding: EdgeInsets.only(bottom: 72),
                  bottomWidget: PreferredSize(
                    preferredSize: Size.fromHeight(10.0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: SizedBox(
                        height: 48,
                        child: AppSearchBar(
                          hintText: 'Search books, authors',
                        ),
                      ),
                    ),
                  ),
                ),
                topBooksData.isEmpty
                    ? SliverContainer(
                        text: 'It\'s such empty',
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                    : AppSliverList(
                        data: topBooksData,
                        itemBuilder: (context, item) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => BookInfoPage(bookId: item["id"]));
                            },
                            child: BookCard(item: item),
                          );
                        },
                      ),
                const SliverToBoxAdapter(
                    child: Padding(padding: EdgeInsets.only(bottom: 36)))
              ],
            ),
    );
  }
}
