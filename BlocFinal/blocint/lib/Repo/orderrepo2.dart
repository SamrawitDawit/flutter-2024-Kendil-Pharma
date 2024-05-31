import 'package:blocint/dataprovider/orderprovider2.dart';
import 'package:blocint/models/ordermodel2.dart';


class Order2Repository {
  final Order2DataProvider dataProvider;

  Order2Repository({required this.dataProvider});

  Future<List<Order2>> fetchOrders(String userId, bool isUser) async {
    return dataProvider.fetchOrders(userId, isUser);
  }

  Future<void> deleteOrder(String orderId) async {
    return dataProvider.deleteOrder(orderId);
  }
}
