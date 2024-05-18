import 'package:flutter/material.dart';

class EditorBottomAppBar extends StatelessWidget {
  EditorBottomAppBar({required this.onItemSelection, super.key});

  final Function(int) onItemSelection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: NavigationBar(
          height: 70,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          shadowColor: Colors.transparent,
          onDestinationSelected: onItemSelection,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.delete,
                color: Colors.black.withOpacity(0.725),
              ),
              label: 'Delete',
              selectedIcon: Icon(
                Icons.delete,
                color: Colors.black.withOpacity(0.725),
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.save,
                color: Colors.black.withOpacity(0.725),
              ),
              selectedIcon: Icon(
                Icons.save,
                color: Colors.black.withOpacity(0.725),
              ),
              label: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
