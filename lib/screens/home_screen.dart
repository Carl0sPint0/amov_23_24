import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                onPressed: () async{
                  final HashMap<String, List<String>> map = await _getSharedPreferences();
                  Navigator.pushNamed(context, '/lastIntPoints', arguments: map);
                },
                child: const Text("Go to history screen"))
          ],
        ),
      ),
    );
  }
}

Future<HashMap<String, List<String>>> _getSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  final HashMap<String, List<String>> map = HashMap<String, List<String>>();
  if(preferences.containsKey('list')){
    map['list'] = preferences.getStringList('list')!;
  }
  return map;
}