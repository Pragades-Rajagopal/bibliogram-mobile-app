import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const BookCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    const height = SizedBox(height: 8.0);
    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 4.0,
      ),
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"],
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  height,
                  Text(
                    item["author"],
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.labelLarge?.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  height,
                  Text(
                    item["gramsCount"] == "1"
                        ? '${item["gramsCount"]} gram posted'
                        : '${item["gramsCount"]} grams posted',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.labelMedium?.fontSize,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.forward,
              color: Theme.of(context).colorScheme.tertiary,
              size: 28.0,
            ),
          ],
        ),
      ),
    );
  }
}
