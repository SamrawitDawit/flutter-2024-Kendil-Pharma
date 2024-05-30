// data_provider.dart
import 'dart:convert';
import 'package:blocint/models/usermodel2.dart';
import 'package:http/http.dart' as http;


class DataProvider {
  final String baseUrl;

  DataProvider({required this.baseUrl});

  Future<Map<String, dynamic>> signUp(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Signup failed: ${response.statusCode}');
    }
  }
}
