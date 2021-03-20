import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/presentation/screens/medications/checkout.dart';
import 'package:dro_health/presentation/screens/medications/medication_detail_screen.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AllMedicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // filter, sort and search options
              _HeaderSection(),

              YBox(10),

              // medications
              Expanded(
                child: _AllMedicationsSection(),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.145,
            minChildSize: 0.145,
            builder: (_, scrollController) {
              return SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: darkPurpleColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: CheckOutContent(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatefulWidget {
  @override
  __HeaderSectionState createState() => __HeaderSectionState();
}

class __HeaderSectionState extends State<_HeaderSection> {
  bool isOpen = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isOpen ? 106 : 50,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                onTap: () {},
                assetSrc: doubleArrows,
              ),
              _ActionButton(
                onTap: () {},
                assetSrc: filter,
              ),
              _ActionButton(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                assetSrc: search,
              ),
            ],
          ),
          YBox(10),
          isOpen
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      suffixIcon: Icon(
                        Icons.close,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: greyColor,
                        ),
                      ),
                      isDense: true,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _AllMedicationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.0).add(
        EdgeInsets.only(top: 5, bottom: 20.0),
      ),
      itemBuilder: (_, int index) {
        return _MedicationCard(
          index: index,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MedicationDetailScreen(
                  medication: null,
                  heroTag: 'heroTag$index',
                ),
              ),
            );
          },
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: 8,
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback onTap;
  final int index;

  const _MedicationCard({Key key, this.medication, this.onTap, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 5),
              color: blackColor.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 7,
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'heroTag$index',
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kezitilSusp),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.all(paddingValue),
              ),
            ),
            YBox(10),
            Text(
              'Kezitil Susp',
              style: theme.textTheme.subtitle1,
            ),
            Text(
              'Cerufutmsill Kezitil Susp',
              style: theme.textTheme.caption,
            ),
            Text(
              'Oral Suspendsion - 100mg',
              style: theme.textTheme.caption,
            ),
            YBox(5),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 20,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: greyColor.withOpacity(0.7),
                ),
                child: Center(
                  child: Text(
                    '\u{20A6}1440',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String assetSrc;

  const _ActionButton({Key key, @required this.onTap, @required this.assetSrc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(45 / 2),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: greyColor.withOpacity(0.2),
        ),
        child: Center(
          child: SvgPicture.asset(
            assetSrc,
          ),
        ),
      ),
    );
  }
}
