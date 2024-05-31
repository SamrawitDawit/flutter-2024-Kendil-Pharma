// bloc/useraccountviewbloc/useraccevent.dart
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserInfo extends UserEvent {
  final String userId;

  const LoadUserInfo(this.userId);

  @override
  List<Object> get props => [userId];
}
