import 'package:blocint/Repo/medaddrepo.dart';
import 'package:blocint/dataprovider/medicinepostprovider.dart';
import 'package:blocint/models/medicinemodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockMedicineProvider extends Mock implements MedicineProvider {}

void main() {
  late MedicineRepository repository;
  late MockMedicineProvider mockProvider;

  setUp(() {
    mockProvider = MockMedicineProvider();
    repository = MedicineRepository(mockProvider);
  });

  final testMedicine = Medicine(
    title: 'Aspirin',
    detail: 'Pain reliever and fever reducer',
    price: '10.00',
    usedfor: 'Pain relief',
    category: 'Analgesic',
  );

  group('MedicineRepository', () {
    test('addMedicine adds medicine successfully', () async {
      // Arrange

      // Act
      await repository.addMedicine(testMedicine);

      // Assert
      verify(() => mockProvider.addMedicine(testMedicine)).called(1);
    });
  });
}
