import 'package:http/http.dart' as http;
import 'dart:convert';

class APIMiddlewares {
  final _PATH = "https://flight-search.onrender.com/api/";
  final _OPTIONS = <String, String> {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<String> postToDatabase({required String path, required Map<String, String> details}) async {
    try {
      await http.post(
        Uri.parse("$_PATH$path"),
        headers: _OPTIONS,
        body: jsonEncode(details)
      );

      return "OK";
    } catch(error) {
      throw error;
    }
  }
}