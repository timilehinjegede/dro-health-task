import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/presentation/screens/screens.dart';
import 'package:dro_health/presentation/widgets/widgets.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:dro_health/logic/cubits.dart';

class AllMedicationScreen extends StatefulWidget {
  @override
  _AllMedicationScreenState createState() => _AllMedicationScreenState();
}

class _AllMedicationScreenState extends State<AllMedicationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AllMedicationCubit>()..fetchAllMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllMedicationCubit, AllMedicationState>(
        builder: (context, state) {
          switch (state.medicationState) {
            case MedicationState.loading:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case MedicationState.success:
              return _BuildHome(
                medicationList: state.medicationList,
              );
              break;
            case MedicationState.failure:
            default:
              return Center(
                child: Text(
                  'Unable to laod medications',
                ),
              );
          }
        },
      ),
    );
  }
}

class _BuildHome extends StatelessWidget {
  final List<Medication> medicationList;

  const _BuildHome({Key key, this.medicationList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      bottom: false,
      child: SlidingSheet(
        elevation: 5,
        cornerRadius: 30,
        addTopViewPaddingOnFullscreen: true,
        color: darkPurpleColor,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.1, 1],
        ),
        builder: (context, state) {
          return CheckOutContent();
        },
        body: SafeArea(
          child: Column(
            children: [
              YBox(10),

              Text(
                '${medicationList.length} ${medicationList.length > 1 ? 'items' : 'item'}',
                style: theme.textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              YBox(10),

              // filter, sort and search options
              _HeaderSection(),

              YBox(10),

              // medications
              Expanded(
                child: _AllMedicationsSection(
                  medicationList: medicationList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatefulWidget {
  @override
  __HeaderSectionState createState() => __HeaderSectionState();
}

class __HeaderSectionState extends State<_HeaderSection>
    with TickerProviderStateMixin {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 45,
          child: Row(
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
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          vsync: this,
          child: isOpen
              ? Column(
                  children: [
                    YBox(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        onChanged: (value) {
                          context.read<AllMedicationCubit>()
                            ..searchAllMedications(value);
                        },
                        onTap: () {
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _AllMedicationsSection extends StatelessWidget {
  final List<Medication> medicationList;

  const _AllMedicationsSection({Key key, this.medicationList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return medicationList.isEmpty
        ? Center(
            child: Text(
              'No available medications found',
            ),
          )
        : GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.0).add(
              EdgeInsets.only(top: 5, bottom: 80.0),
            ),
            itemBuilder: (_, int index) {
              return _MedicationCard(
                medication: medicationList[index],
                index: index,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MedicationDetailScreen(
                        medication: medicationList[index],
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
            itemCount: medicationList.length,
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
                    image: AssetImage(
                      medication.imgSrc,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.all(paddingValue),
              ),
            ),
            YBox(10),
            Text(
              medication.name,
              style: theme.textTheme.bodyText1,
            ),
            Text(
              medication.description,
              style: theme.textTheme.caption,
            ),
            Text(
              medication.type,
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
                    formatMoney(medication.price),
                    style: theme.textTheme.caption.copyWith(
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
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
            color: blackColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
