import 'package:blocint/Repo/orderrepo2.dart';
import 'package:blocint/bloc/orderbloc2/orderevent2.dart';
import 'package:blocint/bloc/orderbloc2/orderstate2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Order2Bloc extends Bloc<Order2Event, Order2State> {
  final Order2Repository repository;

  Order2Bloc({required this.repository}) : super(Order2Initial()) {
    on<FetchOrders2>(_onFetchOrders);
    on<DeleteOrder2>(_onDeleteOrder);
  }

  Future<void> _onFetchOrders(FetchOrders2 event, Emitter<Order2State> emit) async {
    emit(Order2Loading());
    try {
      final orders = await repository.fetchOrders(event.userId, event.isUser);
      emit(Order2Loaded(orders));
    } catch (e) {
      emit(Order2Error(e.toString()));
    }
  }

  Future<void> _onDeleteOrder(DeleteOrder2 event, Emitter<Order2State> emit) async {
    try {
      await repository.deleteOrder(event.orderId);
      if (state is Order2Loaded) {
        final orders = (state as Order2Loaded).orders.where((order) => order.id != event.orderId).toList();
        emit(Order2Loaded(orders));
      }
    } catch (e) {
      emit(Order2Error(e.toString()));
    }
  }
}
