// presentation/screens/add_medicine_screen.dart
import 'package:blocint/bloc/addmedbloc/addmedbloc.dart';
import 'package:blocint/bloc/addmedbloc/addmedevent.dart';
import 'package:blocint/bloc/addmedbloc/addmedstate.dart';
import 'package:blocint/models/medicinemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/KendilAppBar.dart';

class AddMedicineScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _usedforController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KendilAppBar(title: Text('Add Medicine')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            
            TextFormField(
              controller: _usedforController,
              decoration: InputDecoration(labelText: 'Used For'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
              // keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final medicine = Medicine(
                  title: _titleController.text,
                  detail: _descriptionController.text,
                  price: _priceController.text,
                  usedfor: _usedforController.text,
                  category: _categoryController.text,
                );
                context.read<AddMedicineBloc>().add(SubmitMedicineEvent(medicine));
              },
              child: Text(
                'Add Medicine',
                style: TextStyle(color: Colors.lightGreen),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(color: Colors.lightGreen, width: 2),
                ),
              ),
            ),
            BlocListener<AddMedicineBloc, AddMedicineState>(
              listener: (context, state) {
                if (state is AddMedicineSuccess) {
                  Navigator.pop(context, true); // Return true to indicate success
                } else if (state is AddMedicineFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add medicine: ${state.error}')),
                  );
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
