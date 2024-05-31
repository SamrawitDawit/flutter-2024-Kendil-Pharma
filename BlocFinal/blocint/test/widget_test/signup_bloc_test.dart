import 'package:bloc_test/bloc_test.dart';
import 'package:blocint/bloc/signupbloc/sign_bloc.dart';
import 'package:blocint/bloc/signupbloc/signupevent.dart';
import 'package:blocint/bloc/signupbloc/signupstate.dart';
import 'package:blocint/presentation/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockSignupBloc extends MockBloc<SignupEvent, SignupState> implements SignupBloc {}


void main() {
  late MockSignupBloc mockSignupBloc;

  setUp(() {
    mockSignupBloc = MockSignupBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<SignupBloc>(
        create: (context) => mockSignupBloc,
        child: SignupPage(),
      ),
    );
  }

  group('SignupPage', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      when(mockSignupBloc.state).thenReturn(SignupInitial());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Signup'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows SnackBar on signup failure', (WidgetTester tester) async {
      whenListen(
        mockSignupBloc,
        Stream<SignupState>.fromIterable([SignupFailure(error: 'Error')]),
        initialState: SignupInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); 

      expect(find.text('Error'), findsOneWidget);
    });

    testWidgets('navigates to mainpharma on signup success', (WidgetTester tester) async {
      whenListen(
        mockSignupBloc,
        Stream<SignupState>.fromIterable([SignupSuccess(userId: '1', token: 'fake_token')]),
        initialState: SignupInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(); 

      expect(find.text('Signup'), findsNothing);
    });

    testWidgets('submit button triggers signup event', (WidgetTester tester) async {
      when(mockSignupBloc.state).thenReturn(SignupInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextFormField).at(0), 'Name');
      await tester.enterText(find.byType(TextFormField).at(1), 'email@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'password');
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle(); 
      await tester.tap(find.text('Pharmacist').last);
      await tester.pumpAndSettle(); 

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockSignupBloc.add(SignupSubmitted(
        name: 'Name',
        email: 'email@example.com',
        password: 'password',
        role: 'Pharmacist',
      ))).called(1);
    });
  });
}
