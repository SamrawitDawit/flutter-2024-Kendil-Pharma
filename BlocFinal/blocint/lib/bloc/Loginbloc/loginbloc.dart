import 'package:blocint/Repo/loginrepo.dart';
import 'package:blocint/bloc/Loginbloc/loginevent.dart';
import 'package:blocint/bloc/Loginbloc/loginstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final loginResponse = await loginRepository.login(event.email, event.password);
      final bool isPharmacist = loginResponse['Role'] == 'Pharmacist';
      final String token = loginResponse['token'];
      emit(LoginSuccess(isPharmacist: isPharmacist, token: token));

      // Save token and userId to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userId', loginResponse['id']);
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
