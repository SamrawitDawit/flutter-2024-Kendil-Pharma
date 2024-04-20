import 'package:flutter/material.dart';
import 'addmed.dart';
import 'medicine_view.dart';

void main() {
  runApp(MaterialApp(home: ListOFMedicine(isPharmacist: true,)));
}

// import 'package:pharmaui/MedView/medview.dart';

class MedicineItem {
  // final String imagePath;
  final String title;
  final String description;
  final String price;
  final String Manufacuturer;

  MedicineItem({
    // required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.Manufacuturer,
  });
}

class ListOFMedicine extends StatelessWidget {
   final bool isPharmacist;
   ListOFMedicine({super.key,
   required this.isPharmacist}
   );
   

  final List<MedicineItem> medicineItems = [
    MedicineItem(
      
      title: 'Pharmaceutical 1',
      description: 'Used for this and that on this and that for this and that lLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus metus turpis, vel dignissim dolor vulputate dapibus. Proin imperdiet dolor vitae blandit mattis. Aliquam eget eros eu ipsum ultricies hendrerit tincidunt nec velit. Nulla facilisi. ',
      price: 'Price: 300 Birr',
      Manufacuturer: 'Manufacturer: this is the manufacturer'
    ),
    MedicineItem(
      
      title: 'Pharmaceutical 2',
      description: 'Used for something else Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus metus turpis, vel dignissim dolor vulputate dapibus. Proin imperdiet dolor vitae blandit mattis. Aliquam eget eros eu ipsum ultricies hendrerit tincidunt nec velit. Nulla facilisi. ',
      price: 'Price: 250 Birr',
      Manufacuturer: 'Manufacturer: this is the manufacturer'
    ),
    MedicineItem(
      
      title: 'Pharmaceutical 2',
      description: 'Used for something else Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus metus turpis, vel dignissim dolor vulputate dapibus. Proin imperdiet dolor vitae blandit mattis. Aliquam eget eros eu ipsum ultricies hendrerit tincidunt nec velit. Nulla facilisi. ',
      price: 'Price: 250 Birr',
      Manufacuturer: 'Manufacturer: this is the manufacturer'
    ),
    MedicineItem(
      
      title: 'Pharmaceutical 2',
      description: 'Used for something else Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus metus turpis, vel dignissim dolor vulputate dapibus. Proin imperdiet dolor vitae blandit mattis. Aliquam eget eros eu ipsum ultricies hendrerit tincidunt nec velit. Nulla facilisi. ',
      price: 'Price: 250 Birr',
      Manufacuturer: 'Manufacturer: this is the manufacturer'
    ),
    MedicineItem(
      
      title: 'Pharmaceutical 2',
      description: 'Used for something else Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus metus turpis, vel dignissim dolor vulputate dapibus. Proin imperdiet dolor vitae blandit mattis. Aliquam eget eros eu ipsum ultricies hendrerit tincidunt nec velit. Nulla facilisi. ',
      price: 'Price: 250 Birr',
      Manufacuturer: 'Manufacturer: this is the manufacturer'
    ),
    MedicineItem(
      
      title: 'Pharmaceutical 2',
      description: 'Used for something else Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed luctus metus turpis, vel dignissim dolor vulputate dapibus. Proin imperdiet dolor vitae blandit mattis. Aliquam eget eros eu ipsum ultricies hendrerit tincidunt nec velit. Nulla facilisi. ',
      price: 'Price: 250 Birr',
      Manufacuturer: 'Manufacturer: this is the manufacturer'
    ),
    // Add more items as needed...
  ];
  


  @override
  Widget build(BuildContext context) {
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

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: medicineItems.length,
              itemBuilder: (context, index){
                final item1 = medicineItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => MedicineViewPage(
                        medicineItem: item1, 
                        isPharmacist: true)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right : 20),
                    child: Expanded(
                      child: Card(
                        child: Row(
                          children: [
                            // Container(
                            //   width: 100,
                            //   height: 100,
                            //   // margin: EdgeInsets.only(top: 3 , bottom: 3),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(12),
                            //     color: Colors.white,
                            //     image: DecorationImage(
                            //       fit: BoxFit.cover,
                            //       image: AssetImage(item1.imagePath)
                            //   ),
                            // )),
                        
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),

      ],
    );
  }
}


// class MedicineViewPage extends StatelessWidget {
//   final MedicineItem medicineItem;
//   final bool isPharmacist;
//
//   MedicineViewPage({
//     required this.medicineItem,
//     required this.isPharmacist,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Medicine Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               margin: EdgeInsets.only(bottom: 20),
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(5),
//                   bottomRight: Radius.circular(5),
//                 ),
//                 color: Colors.lightGreen,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     medicineItem.title,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.asset(
//                   medicineItem.imagePath,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     medicineItem.description,
//                     style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(15.0, 0, 0,5 ),
//                   child: Text(
//                       medicineItem.Manufacuturer,
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                 ),
//
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(15.0, 0, 0,5 ),
//                   child: Text(
//                       medicineItem.price,
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                 ),
//
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(width: 20),
//                 Expanded(
//                   child: isPharmacist
//                       ? ElevatedButton(
//                           onPressed: () {
//                             // Perform edit action
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.lightGreen,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text(
//                             'Edit',
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                           ),
//                         )
//                       : ElevatedButton(
//                           onPressed: () {
//                             // Perform order action
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.lightGreen,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: Text(
//                             'Order',
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                           ),
//                         ),
//                 ),
//                 SizedBox(width: 20),
//               ],
//             ),
//             SizedBox(height: 20),
//
//           ],
//
//         ),
//       ),
//
//       persistentFooterButtons: [
//         BottomNavigationBarWidget(
//           currentIndex: 0,
//           onTap: (index) {
//             if (index == 0) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MainPharmaPage()),
//               );
//             } else if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddMedicineScreen()),
//               );
//             } else if (index == 2) {
//               // Handle profile navigation
//             }
//           },
//         ),
//       ],
//     );
//   }
// }