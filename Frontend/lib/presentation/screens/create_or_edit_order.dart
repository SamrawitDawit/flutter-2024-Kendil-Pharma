
// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newcompiled/presentation/screens/order_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/KendilAppBar.dart';
import 'package:http/http.dart' as http;


// void main() {
//   runApp(MaterialApp(home: OrderPage()));
// }
class OrderPage extends StatefulWidget {
  final bool isEditing;
  final String? medicineId;
  final int?  amount;
  final DateTime?  date;
  final String user_id;
  OrderPage({required this.isEditing, required this.medicineId, this.amount,  this.date, required this.user_id});

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
    final String user_id = widget.user_id;
    Future<void> storeToken(String token) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }
    Future<void> createOrder(String quantity, String date) async{
      final String medicineId = widget.medicineId!;
      final token = await getToken();
      final response = await http.post(
          Uri.parse('http://10.0.2.2:3000/orders/create'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // 'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            'medicineId': medicineId,
            'quantity': quantity,
            'date': date,
            'userId': user_id,
          },));

      if (response.statusCode == 201){
        print(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderScreen(is_user: true, user_id: user_id,)),
        );
      }else{
        print(user_id);
        print(response.body);
      }
    }


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
                String quantity = _amountController.text.trim();
                String date = _dateController.text.trim();

                if (quantity.isEmpty || date.isEmpty) {
                // Show error message if any of the fields are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields')),
                        );
                } else {
                  // Proceed with creating or editing the order
                  if (isEditing) {
                      // Editing logic
                      int? updateAmount = int.tryParse(quantity);
                      DateTime updatedDate = DateTime.parse(date);
                  } else {
                    // Creating logic

                    String new_amount = quantity.toString();
                    String new_date = date.toString();
                    createOrder(new_amount, new_date);
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
