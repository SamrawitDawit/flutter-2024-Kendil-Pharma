import 'package:blocint/Repo/useraccrepo.dart';
import 'package:blocint/dataprovider/useraccviewprovider.dart';
import 'package:blocint/models/useraccmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockUserProvider extends Mock implements UserProvider {}

void main() {
  late UserRepository repository;
  late MockUserProvider mockUserProvider;

  setUp(() {
    mockUserProvider = MockUserProvider();
    repository = UserRepository(mockUserProvider);
  });

  final testUserId = '1';
  final testUser = User(
    name: 'Test User',
    role: 'Tester',
    email: 'test@example.com',
  );

  group('UserRepository', () {
    test('getUserInfo returns user information', () async {
      // Arrange
      when(() => mockUserProvider.fetchUserInfo(testUserId)).thenAnswer((_) async => testUser);

      // Act
      final result = await repository.getUserInfo(testUserId);

      // Assert
      expect(result, testUser);
      verify(() => mockUserProvider.fetchUserInfo(testUserId)).called(1);
    });
  });
}
