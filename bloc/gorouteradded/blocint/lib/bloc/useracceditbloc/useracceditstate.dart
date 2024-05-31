import 'package:blocint/models/useracceditmodel.dart';
import 'package:equatable/equatable.dart';

abstract class UserState2 extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial2 extends UserState2 {}

class UserLoading2 extends UserState2 {}

class UserLoaded2 extends UserState2 {
  final User2 user;

  UserLoaded2(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError2 extends UserState2 {
  final String error;

  UserError2(this.error);

  @override
  List<Object?> get props => [error];
}
