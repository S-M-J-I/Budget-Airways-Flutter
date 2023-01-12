import 'package:budget_airways/components/CardTitle.dart';
import 'package:budget_airways/components/MyCard.dart';
import 'package:budget_airways/configs/Constants.dart';
import 'package:budget_airways/middlewares/AuthMiddlewares.dart';
import 'package:budget_airways/screens/AuthScreens/SignIn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../middlewares/Dialogs.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  /// TODO:
  ///   - Finish this component
  ///   - add signin/signup navigation
  ///   - add server integration
  ///   - push

  _trySignUp () async {
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
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  width: 30,
                ),
                Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
    final status = await AuthMiddlewares().signUp(
        fullName: _fullNameController.value.text,
        email: _emailController.value.text,
        phone: _phoneController.value.text,
        password: _passwordController.value.text
    );
    Navigator.pop(context);

    if(status!.contains("OK")) {
      Dialogs d = Dialogs();
      d.showWarningDialog(status, context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignIn())
      );
      return;
    }

    Dialogs d = Dialogs();
    d.showWarningDialog(status, context);
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
              const CardTitle(title: "Create an Account"),
              // Full name field
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Email field
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Phone field
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone'
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Password Field
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                    onPressed: _trySignUp,
                    child: const Text("Sign Up")
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              RichText(text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium
                    ),
                    TextSpan(
                        text: 'Sign In',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const SignIn())
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
