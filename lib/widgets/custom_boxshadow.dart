import 'package:flutter/material.dart';

class CustomBoxShadow extends StatelessWidget {
  final Widget _child;

  const CustomBoxShadow(this._child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.125),
            offset: Offset(0, 3),
            blurRadius: 25,
            spreadRadius: -35,
          ),
        ],
      ),
      child: _child,
    );
  }
}
