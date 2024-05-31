import 'package:blocint/dataprovider/list_medicineprovider.dart';
import 'package:blocint/models/list_medicine_model.dart';
import 'package:blocint/repo/listofmedrepo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockListMedicineProvider extends Mock implements ListMedicineProvider {}

void main() {
  late ListMedicineRepository repository;
  late MockListMedicineProvider mockProvider;

  setUp(() {
    mockProvider = MockListMedicineProvider();
    repository = ListMedicineRepository(mockProvider);
  });

  final testToken = 'testToken';
  final testMedicineItem = MedicineItem(
    medid: '1',
    title: 'Aspirin',
    description: 'Pain reliever and fever reducer',
    price: '10.00',
    category: 'Analgesic',
    usedfor: 'Pain relief',
  );

  group('ListMedicineRepository', () {
    test('fetchMedicines returns a list of medicines', () async {
     
      when(() => mockProvider.fetchMedicines(testToken))
          .thenAnswer((_) async => [testMedicineItem]);

     
      final result = await repository.fetchMedicines(testToken);

      
      expect(result, [testMedicineItem]);
      verify(() => mockProvider.fetchMedicines(testToken)).called(1);
    });

    test('deleteMedicine completes successfully', () async {
     
      when(() => mockProvider.deleteMedicine(testMedicineItem.medid, testToken))
          .thenAnswer((_) async => Future.value());

     
      await repository.deleteMedicine(testMedicineItem.medid, testToken);

      // Assert
      verify(() => mockProvider.deleteMedicine(testMedicineItem.medid, testToken)).called(1);
    });

    test('updateMedicine returns an updated medicine item', () async {
      // Arrange
      when(() => mockProvider.updateMedicine(testMedicineItem, testToken))
          .thenAnswer((_) async => testMedicineItem);

      // Act
      final result = await repository.updateMedicine(testMedicineItem, testToken);

      // Assert
      expect(result, testMedicineItem);
      verify(() => mockProvider.updateMedicine(testMedicineItem, testToken)).called(1);
    });
  });
}