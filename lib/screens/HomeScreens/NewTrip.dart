import 'package:budget_airways/components/SearchForm.dart';
import 'package:flutter/material.dart';

class NewTrip extends StatelessWidget {
  const NewTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create a new trip"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: const [
              SearchForm()
            ],
          ),
        ),
      ),
    );
  }
}
