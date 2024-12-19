import 'package:flutter/material.dart';

class GramCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const GramCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 5.0,
      ),
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      data["book"],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Text(
                  data["author"],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              data["gram"],
              style: const TextStyle(
                fontSize: 20.0,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              data["comments"] <= 1
                  ? '${data["comments"]} comment'
                  : '${data["comments"]} comments',
              style: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      data["user"],
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                Text(
                  data["shortDate"],
                  style: TextStyle(
                    fontSize: 14.0,
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
