import 'package:blocint/dataprovider/useracceditprovider.dart';
import 'package:blocint/models/useracceditmodel.dart';

class UserRepository2 {
  final UserDataProvider2 dataProvider;

  UserRepository2({required this.dataProvider});

  Future<User2> getUserInfo() async {
    return await dataProvider.getUserInfo();
  }

  Future<void> updateUserInfo(User2 user) async {
    await dataProvider.updateUserInfo(user);
  }

  Future<void> deleteUserAccount() async {
    await dataProvider.deleteUserAccount();
  }
}
