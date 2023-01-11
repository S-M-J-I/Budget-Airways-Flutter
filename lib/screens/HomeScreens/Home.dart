import 'package:budget_airways/middlewares/AuthMiddlewares.dart';
import 'package:budget_airways/screens/AuthScreens/SignIn.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _showWarningDialog(status) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
          content: Text(status),
          actions: <Widget>[
            TextButton(
              onPressed: () { Navigator.of(ctx).pop(); },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: const Text("Okay"),
              ),
            ),
          ],
        )
    );
  }


  _signOut () async {
    final status = await AuthMiddlewares().signOut();

    if(status!.contains("OK")) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignIn())
      );

      return;
    }

    _showWarningDialog(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Home"),
            ElevatedButton(
                onPressed: _signOut,
                child: const Text('Log Out'),
            )
          ],

        ),
      ),
    );
  }
}
