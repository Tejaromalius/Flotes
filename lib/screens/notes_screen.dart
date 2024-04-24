import 'package:flotes/widgets/widgets.dart' as FlotesWidgets;
import 'package:flotes/services/query_manager.dart' show QueryManager;

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Get.find<QueryManager>().getOrderedNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("An error occurred"));
        }

        if (snapshot.hasData) {
          final documents = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return FlotesWidgets.NoteTile(
                document: documents[index],
                onTap: () =>
                    Get.toNamed('/editor', arguments: documents[index]),
              );
            },
          );
        }

        return const Center(child: Text("No data available"));
      },
    );
  }
}
