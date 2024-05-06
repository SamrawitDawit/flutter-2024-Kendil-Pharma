import 'dart:convert';

import 'package:flutter/material.dart';
import 'addmed.dart';
import 'medicine_view.dart';
import 'package:http/http.dart' as http;
// void main() {
//   runApp(MaterialApp(home: ListOFMedicine(isPharmacist: true,)));
// }

// import 'package:pharmaui/MedView/medview.dart';


class MedicineItem {
  // final String imagePath;
  final String title;
  final String description;
  final String price;
  final String category;

  MedicineItem({
    // required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });
}
class ListOFMedicine extends StatelessWidget {
  final bool isPharmacist;

  ListOFMedicine({Key? key, required this.isPharmacist}) : super(key: key);

  static Future<List<MedicineItem>> fetchMedicines() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/medicines/all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<MedicineItem> medicineItems = data.map((item) => MedicineItem(
        title: item['title'],
        description: item['detail'],
        price: 'Price: ${item['price']} Birr',
        category: 'Category: ${item['category']}',
      )).toList();
      return medicineItems;
    } else {
      throw Exception("Failed to load medicines: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MedicineItem>>(
      future: fetchMedicines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<MedicineItem>? medicineItems = snapshot.data;
          if (medicineItems == null || medicineItems.isEmpty) {
            return Center(child: Text('No medicines found.'));
          }
          return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                      if (isPharmacist)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddMedicineScreen()
                                ));
                            },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.lightGreen, width: 2),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.lightGreen,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        SizedBox(height: 10),

          Column(
            children: [
              // Your other widgets here
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: medicineItems.length,
                itemBuilder: (context, index) {
                  final item1 = medicineItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicineViewPage(
                            medicineItem: item1,
                            isPharmacist: isPharmacist,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        child: Row(
                          children: [
                        Expanded(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.fromLTRB(15,10,0,0),
                                  child: Text(item1.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.lightGreen),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15,0,4,0),
                                  child: Text(item1.description, style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                                    maxLines: 1,),
                                ),
                              ],
                            ),

                            SizedBox(height: 20),

                            Padding(
                              padding:  EdgeInsets.fromLTRB(15, 0, 3,0),
                              child: Text(item1.price, style: TextStyle(color: Colors.green[900]),),
                            )

                          ],
                          )
                        ),
                      ],
                    ),
                  )
                )
              );},
              ),
            ],
          )]);
        }
      },
    );
  }
}
