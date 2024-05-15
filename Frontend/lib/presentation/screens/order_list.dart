import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newcompiled/presentation/screens/create_or_edit_order.dart';
import 'package:newcompiled/presentation/screens/listmedicince.dart';
import '../widget/KendilAppBar.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MaterialApp(home: OrderScreen()));
// }

class OrderScreen extends StatefulWidget {
  final bool is_user;
  final String user_id;
  const OrderScreen({
    Key? key,
    required this.is_user,
    required this.user_id,
  }) : super(key: key);



  @override
  _OrderScreenState createState() => _OrderScreenState();

}

class _OrderScreenState extends State<OrderScreen> {
  static Future<String> getMedicine(med_id) async {

    final response = await http.get(Uri.parse('http://10.0.2.2:3000/medicines/${med_id}'));
    if (response.statusCode == 200) {
      // print(response.body);
      final dynamic data = jsonDecode(response.body);

      // Extract the medicine title from the data
      final String medTitle = data['title'].toString();

      return medTitle;
    } else {
      throw Exception("Failed to load medicine: ${response.statusCode}");
    }
  }

  static Future<List<Order>> fetchOrders(user_id) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/orders/all'));
    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> data = jsonDecode(response.body);
      List<Order> orders = [];
      // Loop through each order
      for (var item in data) {
        // Get the medicine title for the current order
        if (item['userId'] == user_id) {
          print(item);
          String medTitle = await getMedicine(item['medicineId']);
          orders.add(Order(medTitle, item['date']));
        }
      }
      return orders;
    } else {
      throw Exception("Failed to load medicines: ${response.statusCode}");
    }
  }
  @override
  Widget build(BuildContext context) {


    return FutureBuilder<List<Order>>(
        future: fetchOrders(widget.user_id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Order>? orders = snapshot.data;
            if (orders == null || orders.isEmpty) {
              return Center(child: Text('No orders found.'));
            }

    return Scaffold(
      appBar: KendilAppBar(title: Text('My Orders')),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) => SizedBox(height: 10,),
          itemBuilder: (_, index) => OrderCard(
            order: orders[index],
            isUser: widget.is_user,
            onDelete: () {
              setState(() {
                orders.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
});}}

class Order {
  final String medicine;
  final String date;

  Order(this.medicine, this.date);
}

class OrderCard extends StatelessWidget {
  final Order order;
  final bool? isUser;
  final VoidCallback onDelete;

  const OrderCard({
    required this.order,
    required this.isUser,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 130,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          order.medicine,
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 20),
                        Text(order.date.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (isUser ?? true)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => OrderPage(isEditing: true))
                            // );
                            },
                          child: Text('Edit'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          ),
                          onPressed: onDelete,
                          child: Text('Delete', style: TextStyle(color: Colors.blue[900]),),
                        )
                      ],
                    )
                  else
                    Text('user name')
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

