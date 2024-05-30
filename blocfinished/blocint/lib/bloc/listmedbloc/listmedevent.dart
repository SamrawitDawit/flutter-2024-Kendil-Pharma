import 'package:blocint/models/list_medicine_model.dart';
import 'package:equatable/equatable.dart';

abstract class ListMedicineEvent extends Equatable {
  const ListMedicineEvent();

  @override
  List<Object> get props => [];
}

class FetchMedicines extends ListMedicineEvent {
  final String token;

  const FetchMedicines(this.token);

  @override
  List<Object> get props => [token];
}

class DeleteMedicine extends ListMedicineEvent {
  final String medId;
  final String token;

  const DeleteMedicine(this.medId, this.token);

  @override
  List<Object> get props => [medId, token];
}

class EditMedicine extends ListMedicineEvent {
  final MedicineItem medicineItem;
  final String token;

  const EditMedicine(this.medicineItem, this.token);

  @override
  List<Object> get props => [medicineItem, token];
}
