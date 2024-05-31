import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/listofmedrepo.dart';
import 'listmedevent.dart';
import 'listmedstate.dart';

class ListMedicineBloc extends Bloc<ListMedicineEvent, ListMedicineState> {
  final ListMedicineRepository repository;

  ListMedicineBloc(this.repository) : super(MedicineInitial()) {
    on<FetchMedicines>((event, emit) async {
      emit(MedicineLoading());
      try {
        final medicines = await repository.fetchMedicines(event.token);
        emit(MedicineLoaded(medicines));
      } catch (e) {
        emit(MedicineError(e.toString()));
      }
    });

    on<DeleteMedicine>((event, emit) async {
      emit(MedicineLoading());
      try {
        await repository.deleteMedicine(event.medId, event.token);
        final medicines = await repository.fetchMedicines(event.token);
        emit(MedicineLoaded(medicines));
      } catch (e) {
        emit(MedicineError(e.toString()));
      }
    });

    on<EditMedicine>((event, emit) async {
      emit(MedicineLoading());
      try {
        final updatedMedicine = await repository.updateMedicine(event.medicineItem, event.token);
        emit(MedicineUpdated(updatedMedicine));
        final medicines = await repository.fetchMedicines(event.token);
        emit(MedicineLoaded(medicines));
      } catch (e) {
        emit(MedicineError(e.toString()));
      }
    });
  }
}
