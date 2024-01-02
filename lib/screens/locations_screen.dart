// HomeScreen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LocationsScreen extends StatelessWidget {
  LocationsScreen({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Locations')
        ),
      ),
      body:StreamBuilder(
        stream: _firestore.collection('locations').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var documents = snapshot.data?.docs;

          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) {
              var data = documents?[index].data() as Map<String, dynamic>;
              return FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/locations/intPoints', arguments: '${data['id']}');
                  },
                  child: Text(data['name']));
            },
          );
        },
      ),
    );
  }
}

