import 'package:dro_health/data/models/medication.dart';
import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/logic/bag/cubit/bag_cubit.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckOutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<BagCubit, BagState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              YBox(10),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              YBox(10),
              Row(
                children: [
                  SvgPicture.asset(
                    bag,
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                    color: whiteColor,
                  ),
                  XBox(5),
                  Text(
                    'Bag',
                    style: theme.textTheme.headline6.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(45 / 2),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Center(
                        child: Text(
                          state.bagItems.length.toString(),
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              YBox(25),
              Container(
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      color: blackColor.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Tap on an item for add, remove, delete options',
                    style: theme.textTheme.caption.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              YBox(25),
              _BagItemsSection(
                bagItems: state.bagItems,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: whiteColor,
                    ),
                  ),
                  Text(
                    '\u{20A6}6230',
                    style: theme.textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
              YBox(15),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  color: whiteColor,
                  textColor: blackColor,
                  onPressed: () {
                    print(state.bagItems);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    'Checkout',
                    style: theme.textTheme.bodyText1.copyWith(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }
}

class _BagItemsSection extends StatelessWidget {
  final List<BagItem> bagItems;

  const _BagItemsSection({Key key, this.bagItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          bagItems.length,
          (index) => Column(
            children: [
              _BagItemEntry(
                bagItem: bagItems[index],
                onTap: () {},
              ),
              YBox(10),
            ],
          ),
        ),
      ],
    );
  }
}

class _BagItemEntry extends StatelessWidget {
  final BagItem bagItem;
  final VoidCallback onTap;

  const _BagItemEntry({Key key, this.bagItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    bagItem.medication.imgSrc,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            XBox(10),
            Text(
              'x${bagItem.quantity}',
            ),
            XBox(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bagItem.medication.name,
                ),
                Text(
                  bagItem.medication.type,
                ),
              ],
            ),
            Spacer(),
            Text(
              '\u{20A6}${bagItem.medication.price * bagItem.quantity}',
            ),
          ],
        ),
      ),
    );
  }
}
