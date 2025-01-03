import 'package:bibliogram/components/appbar.dart';
import 'package:bibliogram/components/book_card.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/search_bar.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/presentations/app/pages/book_info.dart';
import 'package:bibliogram/services/books.dart';
import 'package:bibliogram/services/search.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _TopBooksState();
}

class _TopBooksState extends State<ExplorePage> {
  final SearchController searchController = SearchController();
  List topBooksData = [];
  List<Map<String, dynamic>> searchResults = [];
  // State variables
  bool _showPageLoader = true;
  Map<String, String>? searchSelection;

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

  Future<void> searchResult(String query) async {
    try {
      if (query.isEmpty) return;
      setState(() => searchResults.clear());
      Map<String, dynamic> userData = await UserToken().getTokenData();
      final response = await SearchApi(userData["token"], userData["id"])
          .getSearchResult(query);
      setState(() {
        searchResults.addAll(response.data!
            .map((item) => item as Map<String, dynamic>)
            .toList());
      });
    } catch (e) {
      if (mounted) {
        CommonWidgets().showSnackBar(
            context, 'Something went wrong during exploration',
            duration: 200);
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
                MyAppBar(
                  title: 'Explore',
                  height: 110,
                  titlePadding: const EdgeInsets.only(bottom: 72),
                  bottomWidget: PreferredSize(
                    preferredSize: const Size.fromHeight(10.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: SizedBox(
                        height: 48,
                        child: AppSearchBar(
                          hintText: ' Explore books, authors, grams',
                          onChanged: (String value) {
                            searchResult(value);
                          },
                          searchResult: searchResults,
                          searchController: searchController,
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
