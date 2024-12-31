import 'package:flutter/material.dart';

class GramCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool showBookMetadata;
  const GramCard({super.key, required this.item, this.showBookMetadata = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
        ),
      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showBookMetadata
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Text(
                            item["book"],
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        item["author"],
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelMedium?.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              item["gram"],
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6.0),
            Text(
              item["comments"] <= 1
                  ? '${item["comments"]} comment'
                  : '${item["comments"]} comments',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      item["user"],
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.labelSmall?.fontSize,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Text(
                  item["shortDate"],
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
