import 'package:bibliogram/presentations/app/pages/grams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasePageGridsBuilder extends StatelessWidget {
  final List data;
  const BasePageGridsBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const GramsPage());
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: data[index]["dataType"] == 'text'
                        ? Text(
                            data[index]["data"],
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                data[index]["icon"],
                                size: 42,
                              ),
                            ],
                          ),
                  ),
                  Text(data[index]["label"])
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
