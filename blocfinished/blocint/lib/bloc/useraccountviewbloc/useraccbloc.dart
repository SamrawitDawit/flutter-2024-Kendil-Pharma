// bloc/useraccountviewbloc/useraccbloc.dart
import 'package:blocint/Repo/useraccrepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'useraccevent.dart';
import 'useraccstate.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUserInfo>(_onLoadUserInfo);
  }

  void _onLoadUserInfo(LoadUserInfo event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUserInfo(event.userId);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to load user info'));
    }
  }
}
