import 'package:blocint/dataprovider/list_medicineprovider.dart';
import 'package:blocint/models/list_medicine_model.dart';


class ListMedicineRepository {
  final ListMedicineProvider provider;

  ListMedicineRepository(this.provider);

  Future<List<MedicineItem>> fetchMedicines(String token) async {
    return await provider.fetchMedicines(token);
  }

  Future<void> deleteMedicine(String medId, String token) async {
    return await provider.deleteMedicine(medId, token);
  }

  Future<MedicineItem> updateMedicine(MedicineItem medicineItem, String token) async {
    return await provider.updateMedicine(medicineItem, token);
  }
}
