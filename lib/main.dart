import 'package:dro_health/data/repositories/all_medication_repositoty.dart';
import 'package:dro_health/presentation/screens/screens.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dro_health/logic/cubits.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final allMedicationRepository = AllMedicationRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AllMedicationCubit(
            allMedicationRepository: allMedicationRepository,
          ),
        ),
        BlocProvider(
          create: (_) => BagCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DroHealth',
        theme: droHealthThemeData,
        home: AllMedicationScreen(),
      ),
    );
  }
}
