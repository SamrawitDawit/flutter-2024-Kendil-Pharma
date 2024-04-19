import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:order_page/KendilAppBar.dart';

void main() {
  runApp(MaterialApp(home: OrderScreen()));
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    Key? key,
    this.is_user = true,
  }) : super(key: key);

  final bool? is_user;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [
    Order('Medicine 1', DateTime(2024, 11, 7)),
    Order('Medicine 2', DateTime(2024, 11, 8)),
    Order('Medicine 3', DateTime(2024, 11, 9)),
    Order('Medicine 4', DateTime(2024, 11, 10)),
    Order('Medicine 5', DateTime(2024, 11, 11)),
  ];

  @override
  Widget build(BuildContext context) {
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
}

class Order {
  final String medicine;
  final DateTime date;

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
                            Navigator.pushNamed(context, '/create_order');
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

