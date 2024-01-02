/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InterestPointDisplayScreen extends StatelessWidget {
  final String queryKey;
  InterestPointDisplayScreen({required this.queryKey, super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    var query = _firestore
        .collection('interest_point')
        .where('id', isEqualTo: queryKey)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Interest Point')
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
              return ListTile(
                title: Text(data['name']),
              );
            },
          );
        },
      ),
    );
  }
}

 */