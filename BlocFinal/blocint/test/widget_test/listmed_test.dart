import 'package:bloc_test/bloc_test.dart';
import 'package:blocint/bloc/listmedbloc/listmedbloc.dart';
import 'package:blocint/bloc/listmedbloc/listmedevent.dart';
import 'package:blocint/bloc/listmedbloc/listmedstate.dart';
import 'package:blocint/presentation/screens/listmedicince.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MockListMedicineBloc extends MockBloc<ListMedicineEvent, ListMedicineState> implements ListMedicineBloc {}

class FakeListMedicineEvent extends Fake implements ListMedicineEvent {}

class FakeListMedicineState extends Fake implements ListMedicineState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeListMedicineEvent());
    registerFallbackValue(FakeListMedicineState());
  });

  group('ListOFMedicine Widget Test', () {
    late ListMedicineBloc mockListMedicineBloc;

    setUp(() {
      mockListMedicineBloc = MockListMedicineBloc();
    });

    Widget createWidgetUnderTest({required NavigatorObserver navigatorObserver}) {
      return MaterialApp(
        home: BlocProvider<ListMedicineBloc>(
          create: (context) => mockListMedicineBloc,
          child: ListOFMedicine(isPharmacist: true, token: 'test-token'),
        ),
        navigatorObservers: [navigatorObserver],
      );
    }

    testWidgets('shows loading indicator when state is MedicineLoading', (tester) async {
      when(() => mockListMedicineBloc.state).thenReturn(MedicineLoading());

      await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when state is MedicineError', (tester) async {
      const errorMessage = 'An error occurred';
      when(() => mockListMedicineBloc.state).thenReturn(MedicineError(errorMessage));

      await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));

      expect(find.text('Error: $errorMessage'), findsOneWidget);
    });

    
   
    testWidgets('shows no medicines found when the list is empty', (tester) async {
      when(() => mockListMedicineBloc.state).thenReturn(MedicineLoaded([]));

      await tester.pumpWidget(createWidgetUnderTest(navigatorObserver: MockNavigatorObserver()));
      await tester.pumpAndSettle();  

      expect(find.text('No medicines found.'), findsOneWidget);
    });

  });
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
