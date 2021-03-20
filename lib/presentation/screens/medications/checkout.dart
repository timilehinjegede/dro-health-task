import 'package:dro_health/data/models/medication.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckOutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              ),
              Text('Bag'),
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
                      '4',
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
              ),
            ),
          ),
          YBox(25),
          _BagItemsSection(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
              ),
              Text(
                '\u{20A6}6230',
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
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'Checkout',
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class _BagItemsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          5,
          (index) => Column(
            children: [
              _BagItemEntry(
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
  final Medication medication;
  final VoidCallback onTap;

  const _BagItemEntry({Key key, this.medication, this.onTap}) : super(key: key);

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
                    garlicAcid,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            XBox(10),
            Text(
              'x1',
            ),
            XBox(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vitamin E 400',
                ),
                Text(
                  'Capsule',
                ),
              ],
            ),
            Spacer(),
            Text(
              '\u{20A6}925',
            ),
          ],
        ),
      ),
    );
  }
}
