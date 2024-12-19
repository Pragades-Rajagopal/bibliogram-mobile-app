import 'package:bibliogram/components/base_page_grids.dart';
import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/services/app_stats.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:bibliogram/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBasePage extends StatefulWidget {
  const AppBasePage({super.key});

  @override
  State<AppBasePage> createState() => _AppBasePageState();
}

class _AppBasePageState extends State<AppBasePage> {
  String? name;
  List homeData = [];
  bool _showPageLoader = false;

  void _togglePageLoader() =>
      setState(() => _showPageLoader = !_showPageLoader);

  @override
  void initState() {
    super.initState();
    initAsyncMethods();
  }

  void initAsyncMethods() async {
    try {
      _togglePageLoader();
      Map<String, dynamic> userData = await UserToken().getTokenData();
      final stats = await AppStatsApi().get(userData["token"], userData["id"]);
      final formattedStatData = formatStatInfo(stats.data!);
      setState(() {
        name = userData["name"];
        homeData.addAll(formattedStatData);
      });
      _togglePageLoader();
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _showPageLoader
          ? CommonWidgets().pageLoadingIndicator(context)
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Welcome'),
                              Text(
                                '$name',
                                style: const TextStyle(fontSize: 30.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.gear),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: BasePageGridsBuilder(data: homeData))
                ],
              ),
            ),
    );
  }
}
