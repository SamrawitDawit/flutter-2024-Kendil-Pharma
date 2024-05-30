import 'dart:convert';
import 'package:blocint/models/ordermodel2.dart';
import 'package:http/http.dart' as http;

class Order2DataProvider {
  final String baseUrl;

  Order2DataProvider({required this.baseUrl});

  Future<List<Order2>> fetchOrders(String userId, bool isUser) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<Order2> orders = [];

      for (var item in data) {
        if (!isUser || item['userId'] == userId) {
          String? medTitle;
          try {
            medTitle = await getMedicine(item['medicineId']);
          } catch (e) {
            medTitle = 'Medicine not available';
          }
          orders.add(Order2.fromJson(item, medTitle));
        }
      }

      return orders;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<String> getMedicine(String medId) async {
    final response = await http.get(Uri.parse('http://localhost:3009/medicines/$medId'));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data['title'];
    } else {
      throw Exception('Failed to load medicine');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    final response = await http.delete(Uri.parse('$baseUrl/orders/$orderId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}
