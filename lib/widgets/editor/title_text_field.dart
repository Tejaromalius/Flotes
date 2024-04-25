import 'package:flutter/material.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField(
    this.titleFocusNode,
    this.titleController, {
    super.key,
  });

  final FocusNode titleFocusNode;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: titleFocusNode,
      controller: titleController,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(fontSize: 32),
      decoration: InputDecoration(
        hintText: titleController.text == '' ? '' : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      maxLines: 1,
      autocorrect: false,
      enableSuggestions: true,
    );
  }
}
