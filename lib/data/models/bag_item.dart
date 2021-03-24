import 'package:dro_health/data/models/models.dart';
import 'package:equatable/equatable.dart';

class BagItem {
  const BagItem({
    this.medication,
    this.quantity ,
  });

  final Medication medication;
  final int quantity ;

  BagItem copyWith({
    final Medication medication,
    final int quantity,
  }) {
    return BagItem(
      medication: medication ?? this.medication,
      quantity: quantity ?? this.quantity,
    );
  }

}