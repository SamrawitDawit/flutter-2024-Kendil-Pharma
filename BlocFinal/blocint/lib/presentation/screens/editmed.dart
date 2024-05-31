import 'package:blocint/bloc/listmedbloc/listmedbloc.dart';
import 'package:blocint/bloc/listmedbloc/listmedevent.dart';
import 'package:blocint/models/list_medicine_model.dart';
import 'package:blocint/presentation/widget/KendilAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMedicineScreen extends StatefulWidget {
  final MedicineItem medicineItem;
  final Function(MedicineItem) onUpdate;
  final String token;

  EditMedicineScreen({
    required this.medicineItem,
    required this.onUpdate,
    required this.token,
  });

  @override
  _EditMedicineScreenState createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _usedForController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicineItem.title);
    _descriptionController = TextEditingController(text: widget.medicineItem.description);
    _priceController = TextEditingController(text: widget.medicineItem.price.split(' ')[1]);
    _categoryController = TextEditingController(text: widget.medicineItem.category.split(' ')[1]);
    _usedForController = TextEditingController(text: widget.medicineItem.usedfor);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _usedForController.dispose();
    super.dispose();
  }

  void _updateMedicine() {
    final updatedItem = MedicineItem(
      medid: widget.medicineItem.medid,
      title: _nameController.text,
      description: _descriptionController.text,
      price: 'Price: ${_priceController.text} Birr',
      category: 'Category: ${_categoryController.text}',
      usedfor: _usedForController.text,
    );

    context.read<ListMedicineBloc>().add(EditMedicine(updatedItem, widget.token));
    widget.onUpdate(updatedItem);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KendilAppBar(title: Text('Edit Medicine')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
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
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _usedForController,
              decoration: InputDecoration(labelText: 'Used For'),
            ),
            SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: _updateMedicine,
              child: Text('Edit Medicine'),
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
