// dataprovider/userprovider.dart
import 'package:blocint/models/useraccmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  final String baseUrl;

  UserProvider(this.baseUrl);

  Future<User> fetchUserInfo(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
