import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/logic/bag/cubit/bag_cubit.dart';
import 'package:dro_health/presentation/widgets/widgets.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MedicationDetailScreen extends StatelessWidget {
  final Medication medication;
  final String heroTag;

  const MedicationDetailScreen({Key key, this.medication, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bagCubit = BlocProvider.of<BagCubit>(context);
    final theme = Theme.of(context);
    return BlocConsumer<BagCubit, BagState>(
      listener: (context, state) {
        switch (state.itemState) {
          case ItemState.initial:
            // TODO: Handle this case.
            break;
          case ItemState.added:
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'label',
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                insetPadding: EdgeInsets.symmetric(horizontal: 20),
                child: SuccessDialog(),
              ),
              transitionBuilder: (_, anim, __, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim),
                  child: child,
                );
              },
            );
            break;
          case ItemState.removed:
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: 'label',
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                insetPadding: EdgeInsets.symmetric(horizontal: 20),
                child: SuccessDialog(
                  isRemoved: true,
                ),
              ),
              transitionBuilder: (_, anim, __, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim),
                  child: child,
                );
              },
            );
            break;
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: whiteColor,
            elevation: 0.0,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Center(
                  child: Container(
                    height: 35,
                    width: 55,
                    decoration: BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          bag,
                        ),
                        BlocBuilder<BagCubit, BagState>(
                          builder: (context, state) {
                            return Text(
                              state.bagItems.length.toString(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              // medication overview i.e image, name and others
              _MedicationOverview(
                heroTag: heroTag,
                medication: medication,
              ),

              YBox(25),

              // price and increase quantity
              _PriceSection(
                medication: medication,
              ),

              YBox(30),

              // product details
              _ProductDetails(
                medication: medication,
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                height: 50,
                child: RaisedButton(
                  textColor: whiteColor,
                  color: purpleColor,
                  onPressed: () {
                    bagCubit.addToBag(medication);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        bag,
                      ),
                      XBox(5),
                      Text(
                        'Add to bag',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MedicationOverview extends StatelessWidget {
  final String heroTag;
  final Medication medication;

  const _MedicationOverview({Key key, this.heroTag, this.medication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Hero(
            tag: heroTag,
            child: Image.asset(
              medication.imgSrc,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        YBox(5),
        Text(
          medication.name,
        ),
        Text(
          medication.type,
        ),
        YBox(20),
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.5),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    emzorLogo,
                  ),
                ),
              ),
            ),
            XBox(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SOLD BY',
                ),
                Text(
                  medication.sellerName,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceSection extends StatefulWidget {
  final Medication medication;

  const _PriceSection({Key key, this.medication}) : super(key: key);

  @override
  __PriceSectionState createState() => __PriceSectionState();
}

class __PriceSectionState extends State<_PriceSection> {
  BagCubit bagCubit;

  @override
  void initState() {
    super.initState();
    bagCubit = BlocProvider.of<BagCubit>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: greyColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              IconButton(
                splashRadius: 20,
                icon: Icon(Icons.remove),
                onPressed: bagCubit.decreaseQuantity,
              ),
              SizedBox(
                width: 20,
                child: Center(
                  child: Text(
                    bagCubit.state.quantity.toString(),
                  ),
                ),
              ),
              IconButton(
                splashRadius: 20,
                icon: Icon(Icons.add),
                onPressed: bagCubit.increaseQuantity,
              ),
            ],
          ),
        ),
        XBox(10),
        Text(
          'Pack(s)',
        ),
        Spacer(),
        Text(
          '\u{20A6}${widget.medication.price}',
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Medication medication;

  const _ProductDetails({Key key, this.medication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRODUCT DETAILS',
        ),
        YBox(10),
        Row(
          children: [
            _ProductDetailsEntry(
              assetSrc: pillPackage,
              info: 'PACK SIZE',
              value: medication.packSize,
            ),
            Spacer(),
            _ProductDetailsEntry(
              assetSrc: productId,
              info: 'PRODUCT ID',
              value: medication.productId,
            ),
            Spacer(),
          ],
        ),
        _ProductDetailsEntry(
            assetSrc: pill,
            info: 'CONSTITUENTS',
            value: medication.constituents),
        _ProductDetailsEntry(
          assetSrc: pillPack,
          info: 'DISPENSED IN',
          value: medication.dispensedIn,
        ),
        YBox(20),
        Align(
          child: Text(
            '1 pack of ${medication.name} contains 3 unit(s) of 10 Tablet(s)',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ProductDetailsEntry extends StatelessWidget {
  final String assetSrc;
  final String info;
  final String value;

  const _ProductDetailsEntry({Key key, this.assetSrc, this.info, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetSrc,
          height: 23,
          color: purpleColor,
          fit: BoxFit.cover,
        ),
        XBox(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info,
            ),
            Text(
              value,
            ),
          ],
        ),
      ],
    );
  }
}
