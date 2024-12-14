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
      body: Center(
        child: Text('Grams'),
      ),
    );
  }
}
