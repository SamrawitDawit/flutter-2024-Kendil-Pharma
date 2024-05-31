import 'package:blocint/Repo/useracceditrepo.dart';
import 'package:blocint/dataprovider/useracceditprovider.dart';
import 'package:blocint/models/useracceditmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserDataProvider2 extends Mock implements UserDataProvider2 {}

void main() {
  late UserRepository2 repository;
  late MockUserDataProvider2 mockDataProvider;

  setUp(() {
    mockDataProvider = MockUserDataProvider2();
    repository = UserRepository2(dataProvider: mockDataProvider);
  });

  final testUser = User2(
    name: 'Test User',
    email: 'test@example.com',
  );

  group('UserRepository2', () {
    test('getUserInfo returns user information', () async {
      
      when(() => mockDataProvider.getUserInfo()).thenAnswer((_) async => testUser);

      
      final result = await repository.getUserInfo();

      
      expect(result, testUser);
      verify(() => mockDataProvider.getUserInfo()).called(1);
    });

    test('updateUserInfo updates user information', () async {
      
      when(() => mockDataProvider.updateUserInfo(testUser)).thenAnswer((_) async => Future.value());

     
      await repository.updateUserInfo(testUser);

      
      verify(() => mockDataProvider.updateUserInfo(testUser)).called(1);
    });

    test('deleteUserAccount completes successfully', () async {
      
      when(() => mockDataProvider.deleteUserAccount()).thenAnswer((_) async => Future.value());

      
      await repository.deleteUserAccount();

      
      verify(() => mockDataProvider.deleteUserAccount()).called(1);
    });
  });
}
