import 'package:blocint/presentation/screens/create_or_edit_order.dart';
import 'package:blocint/presentation/screens/signup.dart';
import 'package:blocint/presentation/screens/useraccountedit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blocint/presentation/screens/login_signup.dart';
import 'package:blocint/presentation/screens/mainpharmapage.dart';
import 'package:blocint/presentation/screens/welcome.dart';
import 'package:blocint/presentation/screens/order_list.dart';
import 'package:blocint/presentation/screens/useraccount.dart';
import 'package:blocint/bloc/listmedbloc/listmedbloc.dart';
import 'package:blocint/bloc/listmedbloc/listmedevent.dart';
import 'package:blocint/Repo/listofmedrepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocint/presentation/screens/editmed.dart';
import 'package:blocint/presentation/screens/addmed.dart';
import 'package:blocint/presentation/screens/medicine_view.dart';

class AppRouter {
  final ListMedicineRepository listMedicineRepository;

  AppRouter({required this.listMedicineRepository});

  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => WelcomePage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/mainpharma',
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final token = extra?['token'] as String?;
          final isPharmacist = extra?['isPharmacist'] as bool?;

          if (token == null || isPharmacist == null) {
            // Handle the case where token or isPharmacist is null
            return Scaffold(
              body: Center(
                child: Text('Invalid navigation parameters.'),
              ),
            );
          }

          return BlocProvider(
            create: (context) => ListMedicineBloc(listMedicineRepository)..add(FetchMedicines(token)),
            child: MainPharmaPage(
              isPharmacist: isPharmacist,
              token: token,
            ),
          );
        },
      ),
      GoRoute(
        path: '/orderlist',
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final isUser = extra?['isUser'] as bool? ?? true;
          final userId = extra?['userId'] as String? ?? '';

          return Order2Screen(
            isUser: isUser,
            userId: userId,
          );
        },
      ),
      GoRoute(
        path: '/useraccount',
        builder: (context, state) => UserAccount(),
      ),
      // Add missing routes
      GoRoute(
        path: '/addmed',
        builder: (context, state) => AddMedicineScreen(),
      ),
      GoRoute(
        path: '/editmed',
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final medicineItem = extra?['medicineItem'];
          final token = extra?['token'];

          if (medicineItem == null || token == null) {
            return Scaffold(
              body: Center(
                child: Text('Invalid navigation parameters.'),
              ),
            );
          }

          return EditMedicineScreen(
            medicineItem: medicineItem,
            onUpdate: extra?['onUpdate'],
            token: token,
          );
        },
      ),
      GoRoute(
        path: '/medicine_view',
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final medicineItem = extra?['medicineItem'];
          final isPharmacist = extra?['isPharmacist'];
          final token = extra?['token'];

          if (medicineItem == null || isPharmacist == null || token == null) {
            return Scaffold(
              body: Center(
                child: Text('Invalid navigation parameters.'),
              ),
            );
          }

          return MedicineViewPage(
            medicineItem: medicineItem,
            isPharmacist: isPharmacist,
            onUpdate: extra?['onUpdate'],
            token: token,
          );
        },
      ),

      GoRoute(
        path: '/create_or_edit_order',
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final isEditing = extra?['isEditing'] as bool? ?? false;
          final medicineId = extra?['medicineId'] as String;

          return OrderPage(
            isEditing: isEditing,
            medicineId: medicineId,
            amount: extra?['amount'] as int?,
            date: extra?['date'] as DateTime?,
            orderId: extra?['orderId'] as String?,
          );
        },
      ),

      GoRoute(
        path: '/useraccount/edit',
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final name = extra?['name'] as String?;
          final email = extra?['email'] as String?;

          if (name == null || email == null) {
            return Scaffold(
              body: Center(
                child: Text('Invalid navigation parameters.'),
              ),
            );
          }

          return UserAccountEditPage2(
            name: name,
            email: email,
          );
        },
      )
    ],
  );
}
