import 'package:flutter/material.dart';
import '../widget/KendilAppBar.dart';

void main() {
  runApp(MaterialApp(home: AddMedicineScreen()));
}

class AddMedicineScreen extends StatelessWidget {
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
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Type'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Manufacturer'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
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