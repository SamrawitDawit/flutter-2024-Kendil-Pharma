// repositories/medicine_repository.dart
import 'package:blocint/dataprovider/medicinepostprovider.dart';
import 'package:blocint/models/medicinemodel.dart';

class MedicineRepository {
  final MedicineProvider medicineProvider;

  MedicineRepository(this.medicineProvider);

  Future<void> addMedicine(Medicine medicine) async {
    await medicineProvider.addMedicine(medicine);
  }
}
