
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class InterestPointsScreen extends StatefulWidget {
  final String queryKey;
  InterestPointsScreen({required this.queryKey, super.key});

  var likePressed = false;
  var dislikePressed = false;
  @override
  State<InterestPointsScreen> createState() => _InterestPointsScreenState();
}

class _InterestPointsScreenState extends State<InterestPointsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    var query = _firestore
        .collection('interest_point')
        .where('locationId', isEqualTo: widget.queryKey)
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

              return Card(
              elevation: 5,
              child: SizedBox(
                  child: Column(
                    children: [
                      Text(data['name']),
                      Text(data['description']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                widget.likePressed = !widget.likePressed;
                                if(widget.likePressed){
                                  uploadDataToFirestore(data, 1, false);
                                }
                                else{
                                  uploadDataToFirestore(data, -1, false);
                                }
                                widget.dislikePressed = false;
                              });
                            }, icon: const Icon(Icons.thumb_up_alt_outlined),
                              selectedIcon: const Icon(Icons.thumb_up),
                            isSelected: widget.likePressed,
                          ),
                          Text(data['likes'].toString()),
                          const Padding(padding: EdgeInsets.all(20)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                widget.dislikePressed = !widget.dislikePressed;
                                if(widget.dislikePressed){
                                  uploadDataToFirestore(data, 1, true);
                                }
                                else{
                                  uploadDataToFirestore(data, -1, true);
                                }
                                widget.likePressed = false;
                              });
                            }, icon: const Icon(Icons.thumb_down_alt_outlined),
                            selectedIcon: const Icon(Icons.thumb_down),
                            isSelected: widget.dislikePressed,
                          ),
                          Text(data['dislikes'].toString())
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> uploadDataToFirestore(Map<String,dynamic> data, int num, bool flag) async {

  CollectionReference collection = FirebaseFirestore.instance.collection('interest_point');

  try {
    if(flag){

      data['dislikes'] = (data['dislikes'] as int) + num;

      await collection.doc(data['id']).set(data);
    }
    else{
      data['likes'] = (data['likes'] as int) + num;

      await collection.doc(data['id']).set(data);
    }
    print('Data uploaded successfully!');
  } catch (e) {
    print('Error uploading data: $e');
  }
}