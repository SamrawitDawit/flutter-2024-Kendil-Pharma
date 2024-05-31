// providers/signup_provider.dart
import 'package:blocint/bloc/signupbloc/sign_bloc.dart';
import 'package:blocint/dataprovider/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupProvider extends StatelessWidget {
  final Widget child;
  final DataProvider dataProvider;

  const SignupProvider({
    Key? key,
    required this.child,
    required this.dataProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(dataProvider: dataProvider),
      child: child,
    );
  }
}
