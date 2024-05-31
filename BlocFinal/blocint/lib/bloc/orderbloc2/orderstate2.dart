import 'package:blocint/models/ordermodel2.dart';
import 'package:equatable/equatable.dart';

abstract class Order2State extends Equatable {
  const Order2State();

  @override
  List<Object> get props => [];
}

class Order2Initial extends Order2State {}

class Order2Loading extends Order2State {}

class Order2Loaded extends Order2State {
  final List<Order2> orders;

  const Order2Loaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class Order2Error extends Order2State {
  final String message;

  const Order2Error(this.message);

  @override
  List<Object> get props => [message];
}
