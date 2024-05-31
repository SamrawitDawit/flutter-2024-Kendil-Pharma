import 'package:blocint/Repo/medaddrepo.dart';
import 'package:blocint/bloc/addmedbloc/addmedevent.dart';
import 'package:blocint/bloc/addmedbloc/addmedstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMedicineBloc extends Bloc<AddMedicineEvent, AddMedicineState> {
  final MedicineRepository medicineRepository;

  AddMedicineBloc(this.medicineRepository) : super(AddMedicineInitial()) {
    on<SubmitMedicineEvent>(_onSubmitMedicineEvent);
  }

  Future<void> _onSubmitMedicineEvent(SubmitMedicineEvent event, Emitter<AddMedicineState> emit) async {
    emit(AddMedicineLoading());
    try {
      await medicineRepository.addMedicine(event.medicine); // No need to assign the result
      emit(AddMedicineSuccess()); // Emit success without a medicine object
    } catch (e) {
      emit(AddMedicineFailure(e.toString()));
    }
  }
}
