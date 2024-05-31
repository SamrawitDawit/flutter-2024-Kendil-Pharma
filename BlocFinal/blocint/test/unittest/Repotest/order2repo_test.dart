import 'package:blocint/Repo/orderrepo2.dart';
import 'package:blocint/dataprovider/orderprovider2.dart';
import 'package:blocint/models/ordermodel2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockOrder2DataProvider extends Mock implements Order2DataProvider {}

void main() {
  late Order2Repository repository;
  late MockOrder2DataProvider mockDataProvider;

  setUp(() {
    mockDataProvider = MockOrder2DataProvider();
    repository = Order2Repository(dataProvider: mockDataProvider);
  });

  final testUserId = '1';
  final testOrderId = '123';
  final testOrder = Order2(
    id: '123',
    medicine: 'Aspirin',
    date: '2023-05-01',
    ordererId: '1',
    medId: 'med1',
    quantity: '2',
  );

  group('Order2Repository', () {
    test('fetchOrders returns a list of orders', () async {
      // Arrange
      when(() => mockDataProvider.fetchOrders(testUserId, true))
          .thenAnswer((_) async => [testOrder]);

      // Act
      final result = await repository.fetchOrders(testUserId, true);

      // Assert
      expect(result, [testOrder]);
      verify(() => mockDataProvider.fetchOrders(testUserId, true)).called(1);
    });

    test('deleteOrder completes successfully', () async {
      // Arrange
      when(() => mockDataProvider.deleteOrder(testOrderId))
          .thenAnswer((_) async => Future.value());

      // Act
      await repository.deleteOrder(testOrderId);

      // Assert
      verify(() => mockDataProvider.deleteOrder(testOrderId)).called(1);
    });
  });
}
