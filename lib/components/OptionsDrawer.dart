import 'package:budget_airways/screens/AuthScreens/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../middlewares/AuthMiddlewares.dart';

class OptionsDrawer extends StatefulWidget {
  const OptionsDrawer({Key? key}) : super(key: key);

  @override
  State<OptionsDrawer> createState() => _OptionsDrawerState();
}

class _OptionsDrawerState extends State<OptionsDrawer> {
  _signOut () async {
    await AuthMiddlewares().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignIn())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Text(
                  "${FirebaseAuth.instance.currentUser!.displayName}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize
                ),
              )
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new, color: Colors.red),
            title: const Text("Log Out"),
            onTap: _signOut,
          )
        ],
      ),
    );
  }
}
