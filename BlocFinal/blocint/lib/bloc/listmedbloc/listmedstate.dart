import 'package:blocint/models/list_medicine_model.dart';
import 'package:equatable/equatable.dart';


abstract class ListMedicineState extends Equatable {
  const ListMedicineState();

  @override
  List<Object> get props => [];
}

class MedicineInitial extends ListMedicineState {}

class MedicineLoading extends ListMedicineState {}

class MedicineLoaded extends ListMedicineState {
  final List<MedicineItem> medicines;

  const MedicineLoaded(this.medicines);

  @override
  List<Object> get props => [medicines];
}

class MedicineError extends ListMedicineState {
  final String message;

  const MedicineError(this.message);

  @override
  List<Object> get props => [message];
}

class MedicineUpdated extends ListMedicineState {
  final MedicineItem updatedMedicine;

  const MedicineUpdated(this.updatedMedicine);

  @override
  List<Object> get props => [updatedMedicine];
}

class MedicineDeleted extends ListMedicineState {}
