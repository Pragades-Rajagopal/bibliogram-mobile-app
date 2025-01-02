import 'package:bibliogram/components/search_card.dart';
import 'package:bibliogram/presentations/app/pages/book_info.dart';
import 'package:bibliogram/presentations/app/pages/gram_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final List<Map<String, dynamic>> searchResult;
  final String hintText;
  final SearchController searchController;
  const AppSearchBar({
    super.key,
    required this.onChanged,
    required this.searchResult,
    required this.hintText,
    required this.searchController,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      searchController: widget.searchController,
      isFullScreen: true,
      onChanged: widget.onChanged,
      suggestionsBuilder: (context, controller) {
        return widget.searchResult.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  controller.closeView('');
                  FocusScope.of(context).unfocus();
                });
                if (item.keys.isNotEmpty) {
                  if (item["type"] == "book") {
                    Get.to(() => BookInfoPage(bookId: item["id"]));
                  } else if (item["type"] == "gram") {
                    Get.to(() => GramInfoPage(gramId: item["id"]));
                  }
                }
              },
              child: SearchCard(item: item),
            ),
          );
        }).toList();
      },
      barLeading: Container(),
      viewBackgroundColor: Theme.of(context).colorScheme.surface,
      barBackgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
      ),
      barHintText: widget.hintText,
      barHintStyle: WidgetStatePropertyAll(
        TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 20.0,
        ),
      ),
      viewHeaderHintStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      dividerColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
    );
  }
}
