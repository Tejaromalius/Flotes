import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteTile extends StatelessWidget {
  final DocumentSnapshot document;

  const NoteTile({required this.document, super.key});

  @override
  Widget build(BuildContext context) {
    final title = document['Title'] ?? 'Untitled';
    final content = document['Content'] ?? '';

    return Column(
      children: [
        Divider(
          thickness: 1,
          endIndent: MediaQuery.of(context).size.width * 0.05,
          indent: MediaQuery.of(context).size.width * 0.05,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          child: ListTile(
            enableFeedback: true,
            splashColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textColor: Theme.of(context).textTheme.bodyLarge?.color,
            tileColor: Theme.of(context).cardColor,
            title: Text(title),
            subtitle: Text(content),
            onTap: () {
              // Handle tap action
            },
          ),
        ),
      ],
    );
  }
}
