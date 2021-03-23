import 'dart:math';

import 'package:dro_health/data/data_providers/medications.dart';
import 'package:dro_health/data/models/models.dart';

class AllMedicationRepository {
  final _random = Random();

  int _randomRange(int min, int max) => min + _random.nextInt(max - min);

  Future<List<Medication>> fetchAllMedications() async {
    await Future.delayed(
      Duration(
        seconds: _randomRange(1, 2),
      ),
    );
    List<Medication> medList = MedicationDataProvider.medicationList;

    return medList;
  }

  List<Medication> searchAllMedications({String medicationName}) {
    List<Medication> medList = [];
    medList = MedicationDataProvider.medicationList
        .where(
          (medication) => medication.name.contains(
            medicationName,
          ),
        )
        .toList();

    return medList;
  }

  // TODO: filter medications
  List<Medication> filterAllMedications() {}

  // TODO: sort medications
  List<Medication> sortAllMedications() {}
}
