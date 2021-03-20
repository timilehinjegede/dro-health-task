import 'package:dro_health/presentation/screens/medications/all_medication_screen.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DroHealth',
      theme: droHealthThemeData,
      home: AllMedicationScreen(),
    );
  }
}
