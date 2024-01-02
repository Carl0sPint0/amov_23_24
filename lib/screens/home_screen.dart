import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Voyage Advisor'),
            FilledButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/locations');
                },
                child: const Text("Go to locations screen")),
            FilledButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/lastIntPoints');
                },
                child: const Text("Go to history screen"))
          ],
        ),
      ),
    );
  }
}