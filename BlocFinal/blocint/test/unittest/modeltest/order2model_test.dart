import 'package:blocint/models/ordermodel2.dart';
import 'package:test/test.dart';

void main() {
  group('Order2 model tests', () {
    test('Create Order2 instance from JSON with medTitle', () {
      final json = {
        '_id': 'order123',
        'date': '2024-05-31',
        'userId': 'user123',
        'medicineId': 'med123',
        'quantity': '2',
      };
      final medTitle = 'Sample Medicine';

      final order2 = Order2.fromJson(json, medTitle);

      expect(order2.id, 'order123');
      expect(order2.medicine, 'Sample Medicine');
      expect(order2.date, '2024-05-31');
      expect(order2.ordererId, 'user123');
      expect(order2.medId, 'med123');
      expect(order2.quantity, '2');
    });
  });
}
