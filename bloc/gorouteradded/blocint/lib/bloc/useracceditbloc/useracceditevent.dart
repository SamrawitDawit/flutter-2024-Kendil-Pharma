import 'package:blocint/models/useracceditmodel.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent2 extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserInfo2 extends UserEvent2 {}

class UpdateUserInfo2 extends UserEvent2 {
  final User2 user;

  UpdateUserInfo2(this.user);

  @override
  List<Object?> get props => [user];
}

class DeleteUserAccount2 extends UserEvent2 {}
