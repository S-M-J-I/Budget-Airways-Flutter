import 'package:budget_airways/components/OptionsDrawer.dart';
import 'package:budget_airways/middlewares/AuthMiddlewares.dart';
import 'package:budget_airways/screens/AuthScreens/SignIn.dart';
import 'package:budget_airways/screens/HomeScreens/NewTrip.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          title: Text("Error"),
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
      appBar: AppBar(
        // leading: const Icon(Icons.view_headline_sharp),
        title: const Text("Budget Airways"),
      ),
      drawer: OptionsDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(40),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NewTrip()));
                  },
                  child: const Text("Search for flights"),
                ),
              ),
            ),
            const SizedBox(height: 30,),
          ],

        ),
      ),
    );
  }
}
