import 'package:flutter/material.dart';
import 'package:pharmaui/Addmed/addmed.dart';
import 'package:pharmaui/Widget/KendilAppBar.dart';
import 'package:pharmaui/home/pharmacat.dart';

import '../Widget/bottomnav.dart';
import 'listmedicince.dart';

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
                  ListOFMedicine(isPharmacist: true)
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
              MaterialPageRoute(builder: (context) => AddMedicineScreen()),
            );
          } else if (index == 2) {
            // Handle profile navigation
          }
        },
      ),
      ),
    );
  }
}