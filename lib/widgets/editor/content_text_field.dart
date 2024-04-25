import 'package:flutter/material.dart';

class ContentTextField extends StatelessWidget {
  const ContentTextField(
    this.contentFocusNode,
    this.contentController, {
    super.key,
  });

  final FocusNode contentFocusNode;
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: contentFocusNode,
        textCapitalization: TextCapitalization.sentences,
        controller: contentController,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
