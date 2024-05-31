import 'package:blocint/dataprovider/loginprovider.dart';


class LoginRepository {
  final LoginDataProvider dataProvider;

  LoginRepository({required this.dataProvider});

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await dataProvider.login(email, password);
  }
}
