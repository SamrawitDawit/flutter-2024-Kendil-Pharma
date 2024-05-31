import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:blocint/bloc/orderbloc2/orderbloc2.dart';
import 'package:blocint/bloc/orderbloc2/orderevent2.dart';
import 'package:blocint/bloc/orderbloc2/orderstate2.dart';
import 'package:blocint/models/ordermodel2.dart';
import 'package:blocint/presentation/screens/order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class MockOrder2Bloc extends MockBloc<Order2Event, Order2State> implements Order2Bloc {}

class FakeOrder2Event extends Fake implements Order2Event {}

class FakeOrder2State extends Fake implements Order2State {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeOrder2Event());
    registerFallbackValue(FakeOrder2State());
  });

  group('Order2Screen Widget Test', () {
    late Order2Bloc mockOrder2Bloc;

    setUp(() {
      mockOrder2Bloc = MockOrder2Bloc();
    });

    Widget createWidgetUnderTest({required NavigatorObserver navigatorObserver}) {
      return MaterialApp(
        home: BlocProvider<Order2Bloc>(
          create: (context) => mockOrder2Bloc,
          child: Order2Screen(isUser: true, userId: 'test-user-id'),
        ),
        navigatorObservers: [navigatorObserver],
      );
    }

    testWidgets('shows loading indicator when state is Order2Loading', (tester) async {
      when(() => mockOrder2Bloc.state).thenReturn(Order2Loading());

      await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when state is Order2Error', (tester) async {
      const errorMessage = 'An error occurred';
      when(() => mockOrder2Bloc.state).thenReturn(Order2Error(errorMessage));

      await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));

      expect(find.text('Error: $errorMessage'), findsOneWidget);
    });

    testWidgets('shows orders when state is Order2Loaded', (tester) async {
      final orders = [
        Order2(
          id: '1',
          medicine: 'Medicine 1',
          quantity: '10',
          date: '2023-05-01',
          ordererId: 'user1',
          medId: 'med1',
        ),
        Order2(
          id: '2',
          medicine: 'Medicine 2',
          quantity: '5',
          date: '2023-05-02',
          ordererId: 'user2',
          medId: 'med2',
        ),
      ];
      when(() => mockOrder2Bloc.state).thenReturn(Order2Loaded(orders));

      await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));
      await tester.pumpAndSettle();  

      expect(find.text('No orders found.'), findsNothing);
      expect(find.text('Medicine 1'), findsOneWidget);
      expect(find.text('Medicine 2'), findsOneWidget);
      expect(find.text('Quantity: 10'), findsOneWidget);
      expect(find.text('Quantity: 5'), findsOneWidget);
    });

    testWidgets('shows no orders found when the list is empty', (tester) async {
      when(() => mockOrder2Bloc.state).thenReturn(Order2Loaded([]));

      await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));
      await tester.pumpAndSettle();  

      expect(find.text('No orders found.'), findsOneWidget);
    });

    testWidgets('shows user name for each order when not isUser', (tester) async {
  final orders = [
    Order2(
      id: '1',
      medicine: 'Medicine 1',
      quantity: '10',
      date: '2023-05-01',
      ordererId: 'user1',
      medId: 'med1',
    ),
  ];
  when(() => mockOrder2Bloc.state).thenReturn(Order2Loaded(orders));

  
  when(() => http.get(Uri.parse('http://localhost:3009/users/user1')))
      .thenAnswer((_) async => http.Response(jsonEncode({'name': 'User 1'}), 200));

  await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));
  await tester.pumpAndSettle();  
  
  verify(() => http.get(Uri.parse('http://localhost:3009/users/user1'))).called(1);
  expect(find.text('User: User 1'), findsOneWidget);
});

  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
