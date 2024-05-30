// dataprovider/medicine_provider.dart
import 'package:blocint/models/medicinemodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineProvider {
  final String baseUrl;

  MedicineProvider(this.baseUrl);

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> addMedicine(Medicine medicine) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/medicines/new'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(medicine.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add medicine');
    }
  }
}
