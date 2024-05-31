// bloc/addmedbloc/addmedstate.dart

abstract class AddMedicineState {}

class AddMedicineInitial extends AddMedicineState {}

class AddMedicineLoading extends AddMedicineState {}

class AddMedicineSuccess extends AddMedicineState {}

class AddMedicineFailure extends AddMedicineState {
  final String error;

  AddMedicineFailure(this.error);
}
