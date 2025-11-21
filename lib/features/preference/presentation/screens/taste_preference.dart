import 'package:flutter/material.dart';

class TastePreference extends StatelessWidget {
  final String imagePath;

  const TastePreference({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taste Preference'), centerTitle: true),
      body: const Column(children: [Text('helllo world')]),
    );
  }
}
