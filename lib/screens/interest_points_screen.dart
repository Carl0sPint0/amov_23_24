import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InterestPointsScreen extends StatelessWidget {
  final String queryKey;
  InterestPointsScreen({required this.queryKey, super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    var query = _firestore
        .collection('interest_point')
        .where('locationId', isEqualTo: queryKey)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Interest Points')
        ),
      ),
      body: StreamBuilder(
        stream: query,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty ?? true) {
            return const Text('No data found.');
          }

          var documents = snapshot.data?.docs;

          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) {
              var data = documents?[index].data() as Map<String, dynamic>;
              return FilledButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/locations/intPoints/intPointDisplay', arguments: data['id']);
                  },
                  child: Text(data['name']));
            },
          );
        },
      ),
    );
  }
}