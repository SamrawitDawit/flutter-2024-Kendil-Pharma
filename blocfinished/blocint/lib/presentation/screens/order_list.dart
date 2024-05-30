import 'dart:convert';
import 'package:blocint/bloc/orderbloc2/orderbloc2.dart';
import 'package:blocint/bloc/orderbloc2/orderevent2.dart';
import 'package:blocint/bloc/orderbloc2/orderstate2.dart';
import 'package:blocint/models/ordermodel2.dart';
import 'package:blocint/presentation/screens/create_or_edit_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class Order2Screen extends StatelessWidget {
  final bool isUser;
  final String userId;

  const Order2Screen({
    Key? key,
    required this.isUser,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger the fetching of orders when the screen is built
    context.read<Order2Bloc>().add(FetchOrders2(userId, isUser));

    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: BlocConsumer<Order2Bloc, Order2State>(
        listener: (context, state) {
          if (state is Order2Error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is Order2Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Order2Error) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is Order2Loaded) {
            final orders = state.orders;
            if (orders.isEmpty) {
              return Center(child: Text('No orders found.'));
            }
            return ListView.separated(
              padding: EdgeInsets.all(12.0),
              itemCount: orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (_, index) => Order2Card(
                order: orders[index],
                isUser: isUser,
                onDelete: () {
                  context.read<Order2Bloc>().add(DeleteOrder2(orders[index].id));
                },
              ),
            );
          } else {
            return Center(child: Text('Unknown state.'));
          }
        },
      ),
    );
  }
}

class Order2Card extends StatelessWidget {
  final Order2 order;
  final bool isUser;
  final VoidCallback onDelete;

  const Order2Card({
    Key? key,
    required this.order,
    required this.isUser,
    required this.onDelete,
  }) : super(key: key);

  Future<String> getUserName(String userId) async {
    final response = await http.get(Uri.parse('http://localhost:3009/users/$userId'));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data['name'];
    } else {
      throw Exception("Failed to load User: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.medicine,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  if (isUser)
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(
                              isEditing: true,
                              medicineId: order.medId,
                              amount: int.tryParse(order.quantity),
                              date: DateTime.tryParse(order.date),
                              orderId: order.id,
                            ),
                          ),
                        );
                      },
                    ),
                  if (isUser)
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Date Ordered: ${order.date}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Quantity: ${order.quantity}',
            style: TextStyle(fontSize: 16),
          ),
          if (!isUser) ...[
            SizedBox(height: 8),
            FutureBuilder<String>(
              future: getUserName(order.ordererId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    'User: ${snapshot.data}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}
