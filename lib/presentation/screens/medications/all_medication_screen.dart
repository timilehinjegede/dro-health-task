import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';

class AllMedicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // filter, sort and search options
          _HeaderSection(),

          SliverToBoxAdapter(
            child: MedicationCard(),
          ),

          // medications
          _AllMedicationsSection(),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        '125 items',
      ),
      centerTitle: true,
      backgroundColor: transparentColor,
      elevation: 0.0,
      leading: Icon(
        Icons.arrow_back,
      ),
    );
  }
}

class _AllMedicationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
    );
  }
}

class MedicationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 5.0,
            color: blackColor.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kezitil),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(paddingValue),
          ),
          YBox(10),
          Text(
            'Kezitil Susp',
          ),
          Text(
            'Cerufutmsill Kezitil Susp',
          ),
          Text(
            'Oral Suspendsion - 100mg',
          ),
        ],
      ),
    );
  }
}
