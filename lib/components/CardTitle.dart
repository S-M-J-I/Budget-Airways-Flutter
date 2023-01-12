import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;
  const CardTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            style: Theme.of(context).textTheme.titleLarge,
            title
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
