import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String orderId;

  const OrderSuccess({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class OrderFailure extends OrderState {
  final String error;

  const OrderFailure({required this.error});

  @override
  List<Object> get props => [error];
}
