import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderDataProvider {
  final String baseUrl;

  OrderDataProvider({required this.baseUrl});

  Future<String> createOrder(String medicineId, int quantity, String date, String userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'medicineId': medicineId,
        'quantity': quantity,
        'date': date,
        'userId': userId,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['_id'];
    } else {
      throw Exception('Failed to create order');
    }
  }

  Future<void> updateOrder(String orderId, int quantity, String date) async {
    final response = await http.put(
      Uri.parse('$baseUrl/orders/$orderId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'quantity': quantity,
        'date': date,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update order');
    }
  }
}
