import 'package:bibliogram/components/appbar.dart';
import 'package:flutter/material.dart';

class GramsPage extends StatefulWidget {
  const GramsPage({super.key});

  @override
  State<GramsPage> createState() => _GramsPageState();
}

class _GramsPageState extends State<GramsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Grams',
      ),
      body: Center(
        child: Text('Grams'),
      ),
    );
  }
}
