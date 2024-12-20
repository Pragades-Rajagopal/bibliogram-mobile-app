import 'package:bibliogram/components/appbar.dart';
import 'package:bibliogram/components/book_card.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/services/books.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBooks extends StatefulWidget {
  const TopBooks({super.key});

  @override
  State<TopBooks> createState() => _TopBooksState();
}

class _TopBooksState extends State<TopBooks> {
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
                MyAppBar(
                  title: 'Top Books',
                  height: 130,
                  titlePadding: const EdgeInsets.only(bottom: 88),
                  bottomWidget: PreferredSize(
                    preferredSize: const Size.fromHeight(10.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: SearchBar(
                        shadowColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.5),
                        ),
                        leading: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.search),
                        ),
                        hintText: 'Search books, authors',
                        hintStyle: WidgetStatePropertyAll(
                          TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        trailing: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(CupertinoIcons.clear),
                          )
                        ],
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
                          return BookCard(item: item);
                        },
                      ),
                const SliverToBoxAdapter(
                    child: Padding(padding: EdgeInsets.only(bottom: 36)))
              ],
            ),
    );
  }
}
