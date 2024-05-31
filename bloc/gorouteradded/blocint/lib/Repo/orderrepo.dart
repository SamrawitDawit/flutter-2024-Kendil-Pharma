import 'package:shared_preferences/shared_preferences.dart';
import 'package:blocint/dataprovider/orderprovider.dart';

class OrderRepository {
  final OrderDataProvider dataProvider;

  OrderRepository({required this.dataProvider});

  Future<String> createOrder(String medicineId, int quantity, String date) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      throw Exception('User ID is null');
    }

    return await dataProvider.createOrder(medicineId, quantity, date, userId);
  }

  Future<void> updateOrder(String orderId, int quantity, String date) async {
    await dataProvider.updateOrder(orderId, quantity, date);
  }
}
