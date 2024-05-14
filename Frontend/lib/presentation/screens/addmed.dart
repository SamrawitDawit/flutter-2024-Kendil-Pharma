import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newcompiled/presentation/screens/mainpharmapage.dart';
import '../widget/KendilAppBar.dart';
import 'package:http/http.dart' as http;
// void main() {
//   runApp(MaterialApp(home: AddMedicineScreen()));
// }

class AddMedicineScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final String user_id;
  AddMedicineScreen({required this.user_id});
  @override
  Widget build(BuildContext context) {

    Future<void> addMed(String title, String description, String price, String category) async{

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/medicines/new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'detail': description,
          'price': price,
          'category': category,
        },));
      if (response.statusCode == 201){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPharmaPage(isPharmacist: true, user_id: user_id,)),
        );
      }else{
        print(response.statusCode);
      }
    }

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
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addMed(_titleController.text, _descriptionController.text, _priceController.text, _categoryController.text);
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
          ],
        ),
      ),
    );
  }
}