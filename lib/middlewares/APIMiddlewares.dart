import 'package:budget_airways/models/Flight.dart';
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

  Future<List<Flight>> getFlights({required String path, required Map<String, String> details}) async {
    try {
      final response = await http.post(
        Uri.parse("$_PATH$path"),
        headers: _OPTIONS,
        body: jsonEncode(details)
      );

      if(response.statusCode == 200) {
        final List res = jsonDecode(response.body);
        return res.map((e) => Flight.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load data");
      }
    }catch(error) {
      throw Exception(error.toString());
    }
  }
}