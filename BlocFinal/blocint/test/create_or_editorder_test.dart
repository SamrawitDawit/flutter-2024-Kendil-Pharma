import 'package:blocint/bloc/orderbloc/orderbloc.dart';
import 'package:blocint/bloc/orderbloc/orderevent.dart';
import 'package:blocint/bloc/orderbloc/orderstate.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:blocint/presentation/screens/create_or_edit_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';


class MockOrderBloc extends MockBloc<OrderEvent, OrderState> implements OrderBloc {}

void main() {
  late OrderBloc orderBloc;

  setUp(() {
    orderBloc = MockOrderBloc();
    when(() => orderBloc.state).thenReturn(OrderInitial());
  });

  tearDown(() {
    orderBloc.close();
  });

  Widget createWidgetUnderTest({required bool isEditing, String? orderId}) {
    return MaterialApp(
      home: BlocProvider<OrderBloc>(
        create: (context) => orderBloc,
        child: OrderPage(
          isEditing: isEditing,
          medicineId: 'test_medicine_id',
          amount: 10,
          date: DateTime.now(),
          orderId: orderId,
        ),
      ),
    );
  }

  testWidgets('should display initial UI elements', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(isEditing: false));

    expect(find.text('Create Order'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('should show "Edit Order" title when isEditing is true', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(isEditing: true, orderId: 'test_order_id'));

    expect(find.text('Edit Order'), findsOneWidget);
  });

  testWidgets('should display error message when fields are empty', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(isEditing: false));

    
    await tester.enterText(find.byType(TextField).first, '');
    await tester.enterText(find.byType(TextField).last, '');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    
    expect(find.text('Please fill all fields'), findsOneWidget);
  });

  testWidgets('should call CreateOrder event on button tap when creating a new order', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(isEditing: false));

    
    await tester.enterText(find.byType(TextField).first, '20');
    await tester.enterText(find.byType(TextField).last, '2023-05-31');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    
    verify(() => orderBloc.add(CreateOrder(
      medicineId: 'test_medicine_id',
      quantity: 20,
      date: '2023-05-31',
    ))).called(1);
  });

  testWidgets('should show error message when OrderFailure state is emitted', (tester) async {
    whenListen(orderBloc, Stream.fromIterable([OrderFailure(error: 'Something went wrong')]), initialState: OrderInitial());

    await tester.pumpWidget(createWidgetUnderTest(isEditing: false));
    await tester.pumpAndSettle();

    
    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
