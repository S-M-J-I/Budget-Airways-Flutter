import 'dart:convert';

import 'package:budget_airways/middlewares/APIMiddlewares.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class AuthMiddlewares {

  Future<String?> signUp({required String fullName, required String email, required String phone, required String password}) async {

    try {

      final details = <String, String>{
        'fullname': fullName,
        'email': email,
        'password': password,
        'phone': phone
      };

      await APIMiddlewares().postToDatabase(path: "users/signup", details: details);

      var userCreds = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCreds.user;

      await user?.updateDisplayName(fullName);

      return "OK";
    } on FirebaseAuthException catch(error) {
      return error.toString();
    } catch (error) {
      return error.toString();
    }
  }


  Future<String?> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "OK";
    } on FirebaseAuthException catch(error) {
      return error.toString();
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "OK";
    } on FirebaseAuthException catch(error) {
      return error.toString();
    } catch (error) {
      return error.toString();
    }
  }
}