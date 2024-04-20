import 'package:flutter/material.dart';
import '../widget/bottomnav.dart';
import 'create_or_edit_order.dart';
import 'editmed.dart';
import 'listmedicince.dart';
import 'mainpharmapage.dart';
import 'order_list.dart';
import 'useraccount.dart';


class MedicineViewPage extends StatelessWidget {
  final MedicineItem medicineItem;
  final bool isPharmacist;

  MedicineViewPage({
    required this.medicineItem,
    required this.isPharmacist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Colors.lightGreen,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicineItem.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.5),
            //         spreadRadius: 2,
            //         blurRadius: 5,
            //         offset: Offset(0, 3),
            //       ),
            //     ],
            //   ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Image.asset(
            //       medicineItem.imagePath,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    medicineItem.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0,5 ),
                  child: Text(
                    medicineItem.Manufacuturer,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0,5 ),
                  child: Text(
                    medicineItem.price,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20),
            Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    SizedBox(width: 20),
    Expanded(
      child: isPharmacist 
          ? ElevatedButton(
              onPressed: () {
                // Navigate to the Edit Medicine page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditMedicineScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
          : ElevatedButton(
              onPressed: () {
                // Navigate to the Order page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Order',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
    ),
    SizedBox(width: 20),
  ],
),
            SizedBox(height: 20),

          ],

        ),
      ),

      persistentFooterButtons: [
        BottomNavigationBarWidget(
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
                MaterialPageRoute(builder: (context)=> UserAccount()));
            }
          },
        ),
      ],
    );
  }
}