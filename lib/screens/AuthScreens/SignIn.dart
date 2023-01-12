import 'package:budget_airways/components/MyCard.dart';
import 'package:budget_airways/components/CardTitle.dart';
import 'package:budget_airways/middlewares/AuthMiddlewares.dart';
import 'package:budget_airways/screens/AuthScreens/SignUp.dart';
import 'package:budget_airways/screens/HomeScreens/Home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../middlewares/Dialogs.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _trySignIn () async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const Text("Loading"),
              ],
            ),
          ),
        );
      },
    );

    final status = await AuthMiddlewares().signIn(email: _emailController.text, password: _passwordController.text);
    Navigator.pop(context);

    if(status!.contains("OK")) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home())
      );
      return;
    }

    Dialogs d = Dialogs();
    d.showWarningDialog(status, context);;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: MyCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CardTitle(
                title: "Sign In",
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email'
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                    onPressed: _trySignIn,
                    child: const Text("Sign In")
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              RichText(text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const SignUp())
                      );
                    }
                  )
                ]
              ))
            ],
          ),
        ),
      ),
    );
  }
}