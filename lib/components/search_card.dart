import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const SearchCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            item["type"] == "book"
                ? CupertinoIcons.book_fill
                : CupertinoIcons.pencil_circle_fill,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          if (item["type"] == 'gram') ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      item["field3"],
                      style: TextStyle(
                        fontSize: 16.0,
                        // fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Text(
                  item["field4"],
                  style: TextStyle(
                    fontSize: 16.0,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          },
          if (item["type"] == 'book') ...{
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
              child: Text(
                item["field1"],
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          } else if (item["type"] == 'gram') ...{
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
              child: Text(
                item["field1"],
                style: const TextStyle(
                  fontSize: 18.0,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          },
          if (item["type"] == 'book') ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 14, 6),
                    child: Text(
                      item["field4"],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Text(
                  item["field5"] == "0"
                      ? 'No notes added'
                      : item["field5"] == "1"
                          ? '${item["field5"]} gram added'
                          : '${item["field5"]} grams added',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          },
          if (item["type"] == 'gram') ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 6),
                    child: Text(
                      item["field2"],
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Text(
                  item["field5"],
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          },
        ],
      ),
    );
  }
}
