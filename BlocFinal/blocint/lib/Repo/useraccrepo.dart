import 'package:blocint/dataprovider/useraccviewprovider.dart';
import 'package:blocint/models/useraccmodel.dart';


class UserRepository {
  final UserProvider userProvider;

  UserRepository(this.userProvider);

  Future<User> getUserInfo(String userId) async {
    return await userProvider.fetchUserInfo(userId);
  }
}
