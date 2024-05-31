import 'package:blocint/models/list_medicine_model.dart';
import 'package:test/test.dart';

void main() {
  group('MedicineItem model tests', () {
    

    test('Convert MedicineItem instance to JSON', () {
      final medicineItem = MedicineItem(
        medid: '2',
        title: 'Medicine B',
        description: 'This is medicine B',
        price: 'Price: 100 Birr',
        category: 'Category: Antibiotics',
        usedfor: 'Infection',
      );

      final json = medicineItem.toJson();

      expect(json['_id'], '2');
      expect(json['title'], 'Medicine B');
      expect(json['detail'], 'This is medicine B');
      expect(json['price'], '100');
      expect(json['category'], 'Antibiotics');
      expect(json['usedfor'], 'Infection');
    });
  });
}
