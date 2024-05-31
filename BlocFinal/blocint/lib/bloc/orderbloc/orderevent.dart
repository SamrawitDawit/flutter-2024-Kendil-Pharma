import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderEvent {
  final String medicineId;
  final int quantity;
  final String date;

  const CreateOrder({
    required this.medicineId,
    required this.quantity,
    required this.date,
  });

  @override
  List<Object> get props => [medicineId, quantity, date];
}

class UpdateOrder extends OrderEvent {
  final String orderId;
  final int quantity;
  final String date;

  const UpdateOrder({
    required this.orderId,
    required this.quantity,
    required this.date,
  });

  @override
  List<Object> get props => [orderId, quantity, date];
}
