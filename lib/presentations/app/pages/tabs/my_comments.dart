import 'package:bibliogram/components/comment_card.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/sliver_container.dart';
import 'package:bibliogram/components/sliver_list.dart';
import 'package:bibliogram/services/comments.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';

class MyCommentsPage extends StatefulWidget {
  const MyCommentsPage({
    super.key,
  });

  @override
  State<MyCommentsPage> createState() => _GramsPageState();
}

class _GramsPageState extends State<MyCommentsPage> {
  final ScrollController scrollController = ScrollController();
  List commentsList = [];
  // Pagination variables
  bool _showPageLoader = true;

  @override
  void initState() {
    super.initState();
    initAsyncMethods();
  }

  void initAsyncMethods() async {
    try {
      Map<String, dynamic> userData = await UserToken().getTokenData();
      final response = await CommentsApi(userData["token"], userData["id"])
          .getComments(userData["id"], 'userId');
      setState(() {
        commentsList.addAll(response.data!);
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
              commentsList.isEmpty
                  ? SliverContainer(
                      text: 'No comments added yet!',
                      color: Theme.of(context).colorScheme.tertiary,
                      padding: const EdgeInsets.only(top: 20),
                    )
                  : AppSliverList(
                      data: commentsList,
                      itemBuilder: (context, item) {
                        return CommentCard(item: item, showUser: false);
                      },
                    ),
              const SliverToBoxAdapter(child: SizedBox(height: 36))
            ], //<Widget>[]
          ); //CustonScrollView
  }
}
