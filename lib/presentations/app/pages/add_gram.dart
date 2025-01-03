import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/mini_button.dart';
import 'package:bibliogram/components/search_bar.dart';
import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/presentations/app/base.dart';
import 'package:bibliogram/services/grams.dart';
import 'package:bibliogram/services/search.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostGramPage extends StatefulWidget {
  const PostGramPage({super.key});

  @override
  State<PostGramPage> createState() => _AddGramPageState();
}

class _AddGramPageState extends State<PostGramPage> {
  SearchController searchController = SearchController();
  bool _privateSwitchValue = true;
  Color? enablePostButton;
  String selectedBookId = '';
  String gramContent = '';
  List<Map<String, dynamic>> searchResults = [];

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
          context,
          'Something went wrong during searching books',
          duration: 200,
        );
      }
    }
  }

  Future<void> postGram(String gram, String bookId, bool isPrivate) async {
    try {
      Map<String, dynamic> userData = await UserToken().getTokenData();
      final response = await GramsApi(userData["token"], userData["id"])
          .postGram({
        "gram": gram,
        "userId": userData["id"],
        "bookId": bookId,
        "isPrivate": isPrivate
      });
      if (response.statusCode == statusCode["serverError"]) {
        if (mounted) {
          CommonWidgets().showSnackBar(
            context,
            'Something went wrong during posting',
            duration: 200,
          );
        }
      } else if (response.statusCode == statusCode["success"]) {
        if (mounted) {
          CommonWidgets().showSnackBar(
            context,
            'Gram posted!',
          );
        }
        Get.offAll(() => const AppBasePage());
      }
    } catch (e) {
      if (mounted) {
        CommonWidgets().showSnackBar(
          context,
          'Something went wrong during posting',
          duration: 200,
        );
      }
    }
  }

  void selectedBook(Map<String, dynamic> selectedItem) {
    setState(() {
      selectedBookId = selectedItem["id"];
      if (selectedItem.isEmpty) {
        enablePostButton =
            Theme.of(context).colorScheme.tertiary.withOpacity(0.6);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          'Post Gram',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 24.0,
          ),
        ),
      ),
      body: Column(
        children: [
          AppSearchBar(
            fullScreen: false,
            isPageRouteFlow: false,
            onChanged: (value) {
              searchResult(value);
            },
            selectedItem: selectedBook,
            searchResult: searchResults,
            hintText: 'Select book',
            searchController: searchController,
            barShape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0), // Optional border
              ),
            ),
            barBackgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.surfaceContainer,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                maxLines: 100,
                // controller: textController,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  hintText: 'gram here...',
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      enablePostButton =
                          value.isNotEmpty && selectedBookId.isNotEmpty
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .tertiary
                                  .withOpacity(0.6);
                      gramContent = value;
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Private gram',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CupertinoSwitch(
                      value: _privateSwitchValue,
                      onChanged: (value) {
                        setState(() {
                          _privateSwitchValue = value;
                        });
                      },
                    ),
                  ],
                ),
                MiniButton(
                  onPressed: () {
                    postGram(gramContent, selectedBookId, _privateSwitchValue);
                  },
                  loadingIndicatorToggle: false,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  icon: CupertinoIcons.paperplane,
                  iconSize: 36,
                  iconColor: enablePostButton ??
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
