import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  const MyCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: child,
      ),
    );
  }
}
