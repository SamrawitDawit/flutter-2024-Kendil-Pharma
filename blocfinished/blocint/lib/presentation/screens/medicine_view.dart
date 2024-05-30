import 'package:blocint/presentation/screens/create_or_edit_order.dart';
import 'package:blocint/presentation/screens/editmed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/list_medicine_model.dart';
import 'package:blocint/bloc/listmedbloc/listmedbloc.dart';

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
      appBar: AppBar(title: Text(medicineItem.title)),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: context.read<ListMedicineBloc>(),
                            child: EditMedicineScreen(
                              medicineItem: medicineItem,
                              onUpdate: _updateMedicineDetails,
                              token: widget.token,
                            ),
                          ),
                        ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPage(
                            isEditing: false,
                            medicineId: medicineItem.medid,
                          ),
                        ),
                      );
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
