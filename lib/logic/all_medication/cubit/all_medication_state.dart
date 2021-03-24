part of 'all_medication_cubit.dart';

enum MedicationState { loading, success, failure }

class AllMedicationState extends Equatable {
  const AllMedicationState({
    this.medicationState = MedicationState.loading,
    this.medicationList = const <Medication>[],
  });

  final MedicationState medicationState;
  final List<Medication> medicationList;

  AllMedicationState copyWith({
    final MedicationState medicationState,
    final List<Medication> medicationList,
  }) {
    return AllMedicationState(
      medicationState: medicationState ?? this.medicationState,
      medicationList: medicationList ?? this.medicationList,
    );
  }

  @override
  List<Object> get props => [medicationState, medicationList];
}
