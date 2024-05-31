import 'package:bloc_test/bloc_test.dart';
import 'package:blocint/bloc/useraccountviewbloc/useraccbloc.dart';
import 'package:blocint/bloc/useraccountviewbloc/useraccevent.dart';
import 'package:blocint/bloc/useraccountviewbloc/useraccstate.dart';
import 'package:blocint/models/useraccmodel.dart';
import 'package:blocint/presentation/screens/useraccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class FakeUserEvent extends Fake implements UserEvent {}

class FakeUserState extends Fake implements UserState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUserEvent());
    registerFallbackValue(FakeUserState());
  });

  late MockUserBloc mockUserBloc;

  setUp(() {
    mockUserBloc = MockUserBloc();
    SharedPreferences.setMockInitialValues({'userId': '12345'});
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<UserBloc>(
        create: (context) => mockUserBloc,
        child: UserAccount(),
      ),
      routes: {
        '/edit_user': (context) => Scaffold(
          body: Center(child: Text('Edit User Screen')),
        ),
      },
    );
  }

  testWidgets('shows CircularProgressIndicator when state is UserLoading', (tester) async {
    when(() => mockUserBloc.state).thenReturn(UserLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows user information when state is UserLoaded', (tester) async {
    final user = User(name: 'Test User', role: 'Tester', email: 'test@example.com');
    when(() => mockUserBloc.state).thenReturn(UserLoaded(user));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('Tester'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
  });

  testWidgets('shows error message when state is UserError', (tester) async {
    const errorMessage = 'Failed to load user info';
    when(() => mockUserBloc.state).thenReturn(UserError(errorMessage));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('shows empty container when state is not UserLoaded in FloatingActionButton', (tester) async {
    when(() => mockUserBloc.state).thenReturn(UserLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(FloatingActionButton), findsNothing);
  });

}
