
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import '../widget/KendilAppBar.dart';

void main() {
  runApp(MaterialApp(home: OrderPage()));
}
class OrderPage extends StatefulWidget {
  final int?  amount;
  final DateTime?  date;
  OrderPage({this.amount,  this.date});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController  _amountController = TextEditingController();
  TextEditingController  _dateController = TextEditingController();


  @override



  @override
  void dispose(){
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  } 
  bool get isEditing => widget.amount != null && widget.date != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KendilAppBar(title: Text(isEditing ? 'Edit Order': 'Create Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40.0,),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                  labelText: 'Amount'
              ),
              keyboardType:  TextInputType.number,
            ),
            SizedBox(height: 30.0,),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                  labelText: 'Date(For when do you want it?)'
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null){
                  _dateController.text = pickedDate.toString();
                }
              },
            ),
            SizedBox(height: 35.0,),
            ElevatedButton(
              onPressed: () {
                String amount = _amountController.text.trim();
                String date = _dateController.text.trim();

                if (amount.isEmpty || date.isEmpty) {
                // Show error message if any of the fields are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields')),
                        );
                } else {
                  // Proceed with creating or editing the order
                  if (isEditing) {
                      // Editing logic
                      int? updateAmount = int.tryParse(amount);
                      DateTime updatedDate = DateTime.parse(date);
                  } else {
                    // Creating logic
                    int? new_amount = int.tryParse(amount);
                    DateTime new_date = DateTime.parse(date);
                  }
                }
                },
              child: Text(isEditing? 'Edit': 'Create', style: TextStyle(color: Colors.lightGreen),),
              style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(color: Colors.lightGreen, width: 2),
                  ),
                ),

            )
          ],
        ),
      ),
    );
  }
}
