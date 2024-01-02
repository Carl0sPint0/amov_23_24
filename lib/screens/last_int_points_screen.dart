import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LastIntPointScreen extends StatelessWidget {
  final Map<String, List<String>> map;
  LastIntPointScreen({required this.map, super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    if (map['list'] == null || map['list']!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Interest Point History'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Historic is empty'),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Interest Point History'),
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot> documents = snapshot.data as List<DocumentSnapshot>;

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var data = documents[index].data() as Map<String, dynamic>;
                  return FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/locations/intPoints', arguments: '${data['id']}');
                    },
                    child: Text(data['name']),
                  );
                },
              );
            }
          },
        ),
      );
    }
  }

  Future<List<DocumentSnapshot>> fetchData() async {
    List<String> ids = map['list'] ?? [];
    QuerySnapshot snapshot = await _firestore.collection('interest_point').where('id', whereIn: ids).get();
    return snapshot.docs;
  }
}
