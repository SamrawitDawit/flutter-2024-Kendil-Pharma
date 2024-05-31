// bloc/signup/signup_bloc.dart
import 'package:blocint/bloc/signupbloc/signupevent.dart';
import 'package:blocint/bloc/signupbloc/signupstate.dart';
import 'package:blocint/dataprovider/userprovider.dart';
import 'package:blocint/models/usermodel2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final DataProvider dataProvider;

  SignupBloc({required this.dataProvider}) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      User user = User(
        name: event.name,
        email: event.email,
        password: event.password,
        role: event.role,
      );
      final response = await dataProvider.signUp(user);

      String token = response['token'];
      String userId = response['usersid'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);

      final prefs2 = await SharedPreferences.getInstance();
      await prefs2.setString('token', token );

      emit(SignupSuccess(userId: userId, token: token));
    } catch (error) {
      emit(SignupFailure(error: error.toString()));
    }
  }
}
