

import 'package:flutter/material.dart';
import 'package:order_page/create_or_edit_order.dart';
import 'package:order_page/medicine_view.dart';
import 'package:order_page/order_list.dart';
void main(){
  runApp(MaterialApp(
    routes: {
      '/': (context) => MedicineView(),
      '/create_order': (context) => OrderPage(),
      '/order_list': (context) => OrderScreen(),
    },
  ));

}
