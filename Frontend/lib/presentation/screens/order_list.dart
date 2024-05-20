import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newcompiled/presentation/screens/create_or_edit_order.dart';
import '../widget/KendilAppBar.dart';
import 'package:http/http.dart' as http;

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

  static Future<List<Order>> fetchOrders(user_id, is_user) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/orders/all'));
    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> data = jsonDecode(response.body);
      List<Order> orders = [];
      // Loop through each order
      if (is_user == false){
        for(var item in data){
          String medTitle = await getMedicine(item['medicineId']);
          String ordererId = item['userId'].toString();
          String orderId = item['_id'].toString();
          String medId = item['medicineId'].toString();
          String quantity = item['quantity'].toString();
          orders.add(Order(orderId, medTitle, item['date'], ordererId, medId, quantity));
        }
        return orders;
      }
      else {
        for (var item in data) {
          // Get the medicine title for the current order
          if (item['userId'] == user_id) {
            print(item);
            String medTitle = await getMedicine(item['medicineId']);
            String ordererId = item['userId'].toString();
            String orderId = item['_id'].toString();
            String medId = item['medicineId'].toString();
            String quantity = item['quantity'].toString();
            orders.add(Order(orderId, medTitle, item['date'], ordererId, medId, quantity));
          }
        }
        return orders;
      }
    } else {
      throw Exception("Failed to load medicines: ${response.statusCode}");
    }
  }
  @override
  Widget build(BuildContext context) {
    Future<void> deleteOrder(orderId) async{
      final response = await http.delete(Uri.parse('http://10.0.2.2:3000/orders/${orderId}'));
    }
    return FutureBuilder<List<Order>>(
        future: fetchOrders(widget.user_id, widget.is_user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Order>? orders = snapshot.data;
            if (orders == null || orders.isEmpty) {
              return Scaffold(
                appBar: KendilAppBar(title: Text('My Orders')),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No orders found.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
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
                deleteOrder(orders[index].id);
                orders.removeAt(index);

              });
            },
            ordererId: orders[index].ordererId,
            quantity: orders[index].quantity,
          ),
        ),
      ),
    );
  }
});}}

class Order {
  final String id;
  final String medicine;
  final String date;
  final String ordererId;
  final String medId;
  final String quantity;
  Order(this.id, this.medicine, this.date, this.ordererId, this.medId, this.quantity);
}

class OrderCard extends StatelessWidget {
  final Order order;
  final bool? isUser;
  final VoidCallback onDelete;
  final String ordererId;
  final String quantity;


  const OrderCard({
    required this.order,
    required this.isUser,
    required this.onDelete,
    required this.ordererId,
    required this.quantity,

  });

  @override
  Widget build(BuildContext context) {
     Future<String> getUserName(user_id) async{
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/users/${user_id}'));
      print(user_id);
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final String userName = data['name'].toString();
        return userName;
      }
      else{
        throw Exception("Failed to load User: ${response.statusCode}");
      }
    }

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
                        SizedBox(width: 20),
                        Text('amount: ${order.quantity}')
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderPage(isEditing: true, medicineId: order.medId, user_id: order.ordererId,)));
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
                    FutureBuilder<String>(
                      future: getUserName(ordererId),
                      builder: (context, snapshot) => snapshot.hasData
                          ? Text(snapshot.data!)
                          : snapshot.hasError
                          ? Text('Error: ${snapshot.error}')
                          : CircularProgressIndicator(),
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

