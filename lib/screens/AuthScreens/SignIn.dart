import 'package:budget_airways/middlewares/AuthMiddlewares.dart';
import 'package:budget_airways/screens/HomeScreens/Home.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  _trySignIn () async {
    final status = await AuthMiddlewares().signIn(email: _emailController.text, password: _passwordController.text);

    if(status!.contains("OK")) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home())
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
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
                onPressed: _trySignIn,
                child: const Text("Login")
            ),
          ],
        ),
      ),
    );
  }
}
