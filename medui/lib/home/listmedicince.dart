import 'package:flutter/material.dart';
import 'package:pharmaui/Addmed/addmed.dart';
import 'package:pharmaui/home/medicineview.dart';


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
                                          overflow: TextOverflow.ellipsis, 
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


