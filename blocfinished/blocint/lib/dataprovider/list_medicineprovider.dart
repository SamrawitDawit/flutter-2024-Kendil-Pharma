import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/list_medicine_model.dart';

class ListMedicineProvider {
  final String baseUrl;

  ListMedicineProvider(this.baseUrl);

  Future<List<MedicineItem>> fetchMedicines(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/medicines'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => MedicineItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load medicines: ${response.statusCode}');
    }
  }

  Future<void> deleteMedicine(String medId, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/medicines/$medId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete medicine: ${response.statusCode}');
    }
  }

  Future<MedicineItem> updateMedicine(MedicineItem medicineItem, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/medicines/${medicineItem.medid}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'title': medicineItem.title,
        'detail': medicineItem.description,
        'price': medicineItem.price.split(' ')[1], // Assuming format "Price: 100 Birr"
        'category': medicineItem.category.split(' ')[1], // Assuming format "Category: XYZ"
        'usedfor': medicineItem.usedfor,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MedicineItem.fromJson(data);
    } else {
      throw Exception('Failed to update medicine: ${response.statusCode}');
    }
  }
}
