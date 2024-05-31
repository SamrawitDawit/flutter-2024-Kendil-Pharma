import 'package:blocint/models/useraccmodel.dart';
import 'package:test/test.dart';

void main() {
  group('User model tests', () {
    test('Create User instance from JSON', () {
      final json = {
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      };

      final user = User.fromJson(json);

      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.role, 'admin');
    });
  });
}
