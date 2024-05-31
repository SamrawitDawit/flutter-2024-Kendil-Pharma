import 'package:blocint/models/medicinemodel.dart';
import 'package:test/test.dart';

void main() {
  group('Medicine model tests', () {
    test('Convert Medicine instance to JSON', () {
      final medicine = Medicine(
        title: 'Medicine A',
        detail: 'This is medicine A',
        price: '50 Birr',
        usedfor: 'Fever',
        category: 'Pain Relief',
      );

      final json = medicine.toJson();

      expect(json['title'], 'Medicine A');
      expect(json['detail'], 'This is medicine A');
      expect(json['price'], '50 Birr');
      expect(json['usedfor'], 'Fever');
      expect(json['category'], 'Pain Relief');
    });
  });
}
