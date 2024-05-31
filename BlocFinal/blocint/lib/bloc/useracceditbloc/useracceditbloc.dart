import 'package:blocint/Repo/useracceditrepo.dart';
import 'package:blocint/bloc/useracceditbloc/useracceditevent.dart';
import 'package:blocint/bloc/useracceditbloc/useracceditstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc2 extends Bloc<UserEvent2, UserState2> {
  final UserRepository2 userRepository;

  UserBloc2({required this.userRepository}) : super(UserInitial2()) {
    on<LoadUserInfo2>((event, emit) async {
      emit(UserLoading2());
      try {
        final user = await userRepository.getUserInfo();
        print('User Loaded: $user'); // Debug statement
        emit(UserLoaded2(user));
      } catch (e) {
        print('Error: $e'); // Debug statement
        emit(UserError2(e.toString()));
      }
    });

    on<UpdateUserInfo2>((event, emit) async {
      emit(UserLoading2());
      try {
        await userRepository.updateUserInfo(event.user);
        final user = await userRepository.getUserInfo();
        emit(UserLoaded2(user));
      } catch (e) {
        emit(UserError2(e.toString()));
      }
    });

    on<DeleteUserAccount2>((event, emit) async {
      emit(UserLoading2());
      try {
        await userRepository.deleteUserAccount();
        emit(UserInitial2()); // Or navigate to login
      } catch (e) {
        emit(UserError2(e.toString()));
      }
    });
  }
}
