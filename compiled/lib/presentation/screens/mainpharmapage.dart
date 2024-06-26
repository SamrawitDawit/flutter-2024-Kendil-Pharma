import 'package:flutter/material.dart';
import '../widget/KendilAppBar.dart';
import '../widget/bottomnav.dart';
import 'listmedicince.dart';
import 'order_list.dart';
import 'pharmacat.dart';
import 'useraccount.dart';

class MainPharmaPage extends StatelessWidget {
  const MainPharmaPage({super.key});

@override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        appBar: KendilAppBar(title: Text('Kendil Products'),) ,
        body: Column(
          children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  const  PharmaPageBody(),
                  SizedBox(height: 10),
                  ListOFMedicine(isPharmacist: true,)
                ],
              ),
            ),
          ),
          
            // SizedBox(height: 25),
            

            // List of of medicine 
            
          ],
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0, 
          onTap: (index) {
          if (index == 0) {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPharmaPage()),
            );
          } else if (index == 1) {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => UserAccount()));
          }
        },
      ),
      ),
    );
  }
}