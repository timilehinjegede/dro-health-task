import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/presentation/widgets/widgets.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dro_health/logic/cubits.dart';

class MedicationDetailScreen extends StatelessWidget {
  final Medication medication;
  final String heroTag;

  const MedicationDetailScreen({Key key, this.medication, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bagCubit = BlocProvider.of<BagCubit>(context);
    final theme = Theme.of(context);
    return BlocConsumer<BagCubit, BagState>(
      listener: (context, state) {
        switch (state.itemState) {
          case ItemState.initial:
            break;
          case ItemState.added:
            buildItemAddedDialog(context);
            break;
          case ItemState.removed:
            buildItemAddedDialog(context, true);
            break;
        }
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
                          color: whiteColor,
                        ),
                        XBox(3),
                        BlocBuilder<BagCubit, BagState>(
                          builder: (context, state) {
                            return Text(
                              state.bagItems.length.toString(),
                              style: theme.textTheme.bodyText1.copyWith(
                                color: whiteColor,
                              ),
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
          bottomNavigationBar: AddItemToBagButton(
            onPressed: () {
              _bagCubit.addItemToBag(medication);
            },
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
    final theme = Theme.of(context);
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
          style: theme.textTheme.headline6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          medication.type,
          style: theme.textTheme.bodyText1,
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
                  style: theme.textTheme.caption.copyWith(
                    fontSize: 10,
                  ),
                ),
                Text(
                  medication.sellerName,
                  style: theme.textTheme.caption.copyWith(
                    color: greenColor,
                  ),
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
  BagCubit _bagCubit;

  @override
  void initState() {
    super.initState();
    _bagCubit = BlocProvider.of<BagCubit>(context);
    _bagCubit.getBagItem(widget.medication);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                icon: Icon(
                  Icons.remove,
                  color: blackColor.withOpacity(.8),
                ),
                onPressed: () => _bagCubit.decreaseItemQuantity(),
              ),
              SizedBox(
                width: 20,
                child: Center(
                  child: Text(
                    _bagCubit.state.bagItem.quantity.toString(),
                  ),
                ),
              ),
              IconButton(
                splashRadius: 20,
                icon: Icon(
                  Icons.add,
                  color: blackColor.withOpacity(.8),
                ),
                onPressed: () => _bagCubit.increaseItemQuantity(),
              ),
            ],
          ),
        ),
        XBox(10),
        Text(
          'Pack(s)',
          style: theme.textTheme.caption,
        ),
        Spacer(),
        Text(
          formatMoney(
            widget.medication.price * _bagCubit.state.bagItem.quantity,
          ),
          style: theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
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
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PRODUCT DETAILS',
          style: theme.textTheme.caption,
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
        YBox(5),
        _ProductDetailsEntry(
          assetSrc: pill,
          info: 'CONSTITUENTS',
          value: medication.constituents,
        ),
        YBox(5),
        _ProductDetailsEntry(
          assetSrc: pillPack,
          info: 'DISPENSED IN',
          value: medication.dispensedIn,
        ),
        YBox(20),
        Align(
          child: Text(
            '1 pack of ${medication.name} contains 3 unit(s) of 10 Tablet(s)',
            style: theme.textTheme.caption,
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
    final theme = Theme.of(context);
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
              style: theme.textTheme.caption.copyWith(fontSize: 10),
            ),
            YBox(3),
            Text(
              value,
              style: theme.textTheme.caption.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: blackColor.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
