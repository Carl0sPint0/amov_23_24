// HomeScreen.dart
import 'package:flutter/material.dart';

class LastIntPointScreen extends StatelessWidget {
  const LastIntPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interest Point History'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is history'),
          ],
        ),
      ),
    );
  }
}