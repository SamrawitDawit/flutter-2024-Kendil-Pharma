import 'package:blocint/bloc/orderbloc/orderevent.dart';
import 'package:blocint/bloc/orderbloc/orderstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blocint/Repo/orderrepo.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<CreateOrder>(_onCreateOrder);
    on<UpdateOrder>(_onUpdateOrder);
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final orderId = await orderRepository.createOrder(
        event.medicineId,
        event.quantity,
        event.date,
      );
      emit(OrderSuccess(orderId: orderId));
    } catch (e) {
      emit(OrderFailure(error: e.toString()));
    }
  }

  Future<void> _onUpdateOrder(UpdateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      await orderRepository.updateOrder(
        event.orderId,
        event.quantity,
        event.date,
      );
      emit(OrderSuccess(orderId: event.orderId));
    } catch (e) {
      emit(OrderFailure(error: e.toString()));
    }
  }
}
