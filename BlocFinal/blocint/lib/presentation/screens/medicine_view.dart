import 'package:blocint/presentation/widget/KendilAppBar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/list_medicine_model.dart';

class MedicineViewPage extends StatefulWidget {
  final MedicineItem medicineItem;
  final bool isPharmacist;
  final Function(MedicineItem) onUpdate;
  final String token;

  MedicineViewPage({
    required this.medicineItem,
    required this.isPharmacist,
    required this.onUpdate,
    required this.token,
  });

  @override
  _MedicineViewPageState createState() => _MedicineViewPageState();
}

class _MedicineViewPageState extends State<MedicineViewPage> {
  late MedicineItem medicineItem;

  @override
  void initState() {
    super.initState();
    medicineItem = widget.medicineItem;
  }

  void _updateMedicineDetails(MedicineItem updatedItem) {
    setState(() {
      medicineItem = updatedItem;
    });
    widget.onUpdate(updatedItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KendilAppBar(title: Text(medicineItem.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              medicineItem.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              medicineItem.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              medicineItem.price,
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              medicineItem.category,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            Text(
              'Used for: ${medicineItem.usedfor}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            widget.isPharmacist
                ? OutlinedButton(
                    onPressed: () {
                     context.push(
                        '/editmed',
                        extra: {
                          'medicineItem': medicineItem,
                          'onUpdate': _updateMedicineDetails,
                          'token': widget.token,
                        },
                      );
                 
                    },
                    child: Text('Edit Medicine'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green, 
                      side: BorderSide(color: Colors.green),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () {
                        // ignore: unnecessary_null_comparison
                        if (medicineItem.medid != null) {
                        context.push(
                          '/create_or_edit_order',
                          extra: {
                            'isEditing': false,
                            'medicineId': medicineItem.medid,
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid medicine ID')),
                        );
                      }
                    },
                    child: Text('Order Now'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green, 
                      side: BorderSide(color: Colors.green),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
