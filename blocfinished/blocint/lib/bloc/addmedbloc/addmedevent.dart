// bloc/addmedbloc/addmedevent.dart
import 'package:blocint/models/medicinemodel.dart';

abstract class AddMedicineEvent {}

class SubmitMedicineEvent extends AddMedicineEvent {
  final Medicine medicine;

  SubmitMedicineEvent(this.medicine);
}
