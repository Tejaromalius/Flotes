import 'package:flotes/services/query_manager.dart' show QueryManager;
import 'package:flotes/widgets/widgets.dart' as FlotesWidgets;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditorPage extends StatefulWidget {
  late final DocumentSnapshot<Object?>? document;
  EditorPage({Key? key}) : super(key: key) {
    this.document = Get.arguments;
  }
  @override
  _EditorPageState createState() => _EditorPageState(document);
}

class _EditorPageState extends State<EditorPage> {
  DocumentSnapshot<Object?>? document;

  late FocusNode titleFocusNode;
  late FocusNode contentFocusNode;

  late TextEditingController titleController;
  late TextEditingController contentController;

  late String _lastEditDate;

  _EditorPageState(this.document) {
    titleFocusNode = FocusNode();
    titleController = TextEditingController(text: document?['Title'] ?? '');

    contentFocusNode = FocusNode();
    contentController = TextEditingController(text: document?['Content'] ?? '');
    _lastEditDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(
        document?['LastEditDate'] != null
            ? (document?['LastEditDate'] as Timestamp).toDate()
            : DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FlotesWidgets.TitleTextField(titleFocusNode, titleController),
            FlotesWidgets.LastEditedDivider(lastEditDate: _lastEditDate),
            FlotesWidgets.ContentTextField(contentFocusNode, contentController),
          ],
        ),
      ),
      bottomNavigationBar: FlotesWidgets.EditorBottomAppBar(
          onItemSelection: (int menuItemIndex) async {
        if (menuItemIndex == 1) {
          await _saveNote();
        } else {
          await _deleteNote();
        }
      }),
    );
  }

  Future<void> _deleteNote() async {
    if (document != null) {
      await Get.find<QueryManager>().deleteNote(document!);
    }
    Get.back();

    FlotesWidgets.showSnackBar(
      context,
      message: 'Note deleted',
      color: Colors.red,
    );
  }

  Future<void> _saveNote() async {
    if (titleController.text.isEmpty) {
      FlotesWidgets.showSnackBar(
        context,
        message: 'Title cannot be empty',
        color: Colors.red,
      );
      return;
    }

    this.document = document == null
        ? await Get.find<QueryManager>().createAndGetNote(
            titleController.text,
            contentController.text,
          )
        : await Get.find<QueryManager>().updateAndGetNote(
            document!,
            titleController.text,
            contentController.text,
          );

    if (titleFocusNode.hasFocus) titleFocusNode.unfocus();
    if (contentFocusNode.hasFocus) contentFocusNode.unfocus();

    setState(() => _lastEditDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));

    FlotesWidgets.showSnackBar(
      context,
      message: 'Note saved',
      color: Colors.green,
    );
  }
}
