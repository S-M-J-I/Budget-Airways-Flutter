import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthMiddlewares {
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