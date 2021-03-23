import 'package:bloc/bloc.dart';
import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/data/repositories/all_medication_repositoty.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'all_medication_state.dart';

class AllMedicationCubit extends Cubit<AllMedicationState> {
  AllMedicationCubit({@required this.allMedicationRepository})
      : super(AllMedicationState());

  final AllMedicationRepository allMedicationRepository;

  Future<void> fetchAllMedications() async {
    try {
      final medications = await allMedicationRepository.fetchAllMedications();

      emit(
        state.copyWith(
          medicationState: MedicationState.success,
          medicationList: medications,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          medicationState: MedicationState.failure,
        ),
      );
    }
  }

  Future<void> searchAllMedications(String medicationName) async {
    try {
      final medications = await allMedicationRepository.searchAllMedications(
        medicationName: medicationName,
      );

      emit(
        state.copyWith(
          medicationState: MedicationState.success,
          medicationList: medications ?? [],
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          medicationState: MedicationState.failure,
        ),
      );
    }
  }

  Future<void> filterAllMedications() {}

  Future<void> sortAllMedications() {}
}
