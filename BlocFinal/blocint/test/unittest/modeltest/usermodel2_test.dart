import 'package:blocint/models/usermodel2.dart';
import 'package:test/test.dart';

void main() {
  group('User model tests', () {
    test('Create User instance from JSON', () {
      final json = {
        'name': 'John Doe',
        'email': 'john@example.com',
        'password': 'password123',
        'role': 'admin',
      };

      final user = User.fromJson(json);

      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'password123');
      expect(user.role, 'admin');
    });

    test('Convert User instance to JSON', () {
      final user = User(
        name: 'Jane Doe',
        email: 'jane@example.com',
        password: 'password456',
        role: 'user',
      );

      final json = user.toJson();

      expect(json['name'], 'Jane Doe');
      expect(json['email'], 'jane@example.com');
      expect(json['password'], 'password456');
      expect(json['role'], 'user');
    });
  });
}
