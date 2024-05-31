import 'package:blocint/bloc/orderbloc/orderbloc.dart';
import 'package:blocint/bloc/orderbloc/orderevent.dart';
import 'package:blocint/bloc/orderbloc/orderstate.dart';
import 'package:blocint/presentation/widget/KendilAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  final bool isEditing;
  final String medicineId;
  final int? amount;
  final DateTime? date;
  final String? orderId;

  OrderPage({
    required this.isEditing,
    required this.medicineId,
    this.amount,
    this.date,
    this.orderId,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late TextEditingController _amountController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.amount?.toString() ?? '');
    _dateController = TextEditingController(text: widget.date?.toIso8601String() ?? '');
  }

  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KendilAppBar(
        title: Text(widget.isEditing ? 'Edit Order' : 'Create Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40.0),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (pickedDate != null) {
                  String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                  _dateController.text = formattedDate;
                }
              },
            ),
            SizedBox(height: 35.0),
            ElevatedButton(
              onPressed: () {
                String quantity = _amountController.text.trim();
                String date = _dateController.text.trim();

                if (quantity.isEmpty || date.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                } else {
                  if (widget.isEditing) {
                    BlocProvider.of<OrderBloc>(context).add(UpdateOrder(
                      orderId: widget.orderId!,
                      quantity: int.parse(quantity),
                      date: date,
                    ));
                  } else {
                    BlocProvider.of<OrderBloc>(context).add(CreateOrder(
                      medicineId: widget.medicineId,
                      quantity: int.parse(quantity),
                      date: date,
                    ));
                  }
                }
              },
              child: Text(widget.isEditing ? 'Update Order' : 'Create Order', style: TextStyle(color: Colors.green),),
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  BorderSide(color: Colors.green),
                  
                ),
              )
            ),
            BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderSuccess) {
                  Navigator.pop(context, true); 
                } else if (state is OrderFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
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
