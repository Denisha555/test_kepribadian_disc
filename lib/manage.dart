import 'package:flutter/material.dart';

class Manage extends StatelessWidget {
  const Manage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage'),
      ),
      body: const Center(
        child: Text('This is the Manage Page'),
      ),
    );
  }
}