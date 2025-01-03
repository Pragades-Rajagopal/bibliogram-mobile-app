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
  final bool fullScreen;
  final WidgetStateProperty<OutlinedBorder?>? barShape;
  final WidgetStateProperty<Color?>? barBackgroundColor;
  final Function(Map<String, dynamic>)? selectedItem;
  final bool isPageRouteFlow;
  const AppSearchBar({
    super.key,
    required this.onChanged,
    required this.searchResult,
    required this.hintText,
    required this.searchController,
    this.fullScreen = true,
    this.barShape,
    this.barBackgroundColor,
    this.selectedItem,
    this.isPageRouteFlow = true,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      searchController: widget.searchController,
      isFullScreen: widget.fullScreen,
      onChanged: widget.onChanged,
      suggestionsBuilder: (context, controller) {
        return widget.searchResult.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.isPageRouteFlow
                      ? controller.closeView('')
                      : controller.closeView(item["field1"]);
                  FocusScope.of(context).unfocus();
                });

                if (widget.isPageRouteFlow && item.keys.isNotEmpty) {
                  if (item["type"] == "book") {
                    Get.to(() => BookInfoPage(bookId: item["id"]));
                  } else if (item["type"] == "gram") {
                    Get.to(() => GramInfoPage(gramId: item["id"]));
                  }
                } else if (!widget.isPageRouteFlow) {
                  widget.selectedItem!(item);
                }
              },
              child: SearchCard(item: item),
            ),
          );
        }).toList();
      },
      barLeading: Container(),
      viewBackgroundColor: Theme.of(context).colorScheme.surface,
      barBackgroundColor: widget.barBackgroundColor ??
          WidgetStatePropertyAll(
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
      barShape: widget.barShape,
      barOverlayColor: const WidgetStatePropertyAll(Colors.transparent),
      viewShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0), // Optional border
      ),
    );
  }
}
