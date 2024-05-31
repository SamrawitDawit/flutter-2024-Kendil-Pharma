import 'package:equatable/equatable.dart';

abstract class Order2Event extends Equatable {
  const Order2Event();

  @override
  List<Object> get props => [];
}

class FetchOrders2 extends Order2Event {
  final String userId;
  final bool isUser;

  const FetchOrders2(this.userId, this.isUser);

  @override
  List<Object> get props => [userId, isUser];
}

class DeleteOrder2 extends Order2Event {
  final String orderId;

  const DeleteOrder2(this.orderId);

  @override
  List<Object> get props => [orderId];
}
