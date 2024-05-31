import 'package:blocint/models/ordermodel.dart';
import 'package:test/test.dart';

void main() {
  group('Order model tests', () {
    test('Convert Order instance to JSON', () {
      final date = DateTime.now();
      final order = Order(
        medicineId: 'med123',
        quantity: 2,
        date: date,
        userId: 'user123',
      );

      final json = order.toJson();

      expect(json['medicineId'], 'med123');
      expect(json['quantity'], '2');
      expect(json['date'], date.toIso8601String());
      expect(json['userId'], 'user123');
    });

    test('Convert JSON to Order instance', () {
      final date = DateTime.now();
      final json = {
        '_id': 'order123',
        'medicineId': 'med123',
        'quantity': '2',
        'date': date.toIso8601String(),
        'userId': 'user123',
      };

      final order = Order.fromJson(json);

      expect(order.id, 'order123');
      expect(order.medicineId, 'med123');
      expect(order.quantity, 2);
      expect(order.date, date);
      expect(order.userId, 'user123');
    });
  });
}
