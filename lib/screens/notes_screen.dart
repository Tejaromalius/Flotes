import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      color: Colors.purple,
      child: Center(
        child: Text('Notes Page'),
      ),
    );
  }
}
