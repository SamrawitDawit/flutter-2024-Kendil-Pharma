import 'package:blocint/Repo/listofmedrepo.dart';
import 'package:blocint/bloc/listmedbloc/listmedbloc.dart';
import 'package:blocint/bloc/listmedbloc/listmedevent.dart';
import 'package:blocint/presentation/screens/listmedicince.dart';
import 'package:blocint/presentation/screens/pharmacat.dart';
import 'package:blocint/presentation/widget/KendilAppBar.dart';
import 'package:blocint/presentation/widget/bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPharmaPage extends StatelessWidget {
  final bool isPharmacist;
  final String token;

  const MainPharmaPage({
    super.key,
    required this.isPharmacist,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: KendilAppBar(
          title: Text('Kendil Products'),
          actions: [
            Tooltip(
              message: 'Logout',
              child: IconButton(
                icon: Icon(Icons.logout_outlined, color: Colors.redAccent, size: 30),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  await prefs.remove('userId');
                  context.go('/');
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    const PharmaPageBody(),
                    SizedBox(height: 10),
                    BlocProvider(
                      create: (context) => ListMedicineBloc(
                        context.read<ListMedicineRepository>(),
                      )..add(FetchMedicines(token)),
                      child: ListOFMedicine(
                        isPharmacist: isPharmacist,
                        token: token,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentIndex: 0,
          onTap: (index) async {
            if (index == 0) {
             context.go('/mainpharma', extra: {'token': token, 'isPharmacist': isPharmacist});
            } else if (index == 1) {
              final prefs = await SharedPreferences.getInstance();
              final userId = prefs.getString('userId') ?? '';
              context.go('/orderlist', extra: {'isUser': !isPharmacist, 'userId': userId});
            } else if (index == 2) {
              context.go('/useraccount');
            }
          },
        ),
      ),
    );
  }
}
