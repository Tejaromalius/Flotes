import 'package:flutter/material.dart';

class LastEditedDivider extends StatelessWidget {
  const LastEditedDivider({
    required this.lastEditDate,
    super.key,
  });

  final String lastEditDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              lastEditDate,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
