import 'package:dro_health/data/models/models.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MedicationDetailScreen extends StatelessWidget {
  final Medication medication;
  final String heroTag;

  const MedicationDetailScreen({Key key, this.medication, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    Text('3'),
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
          _MedicationOverview(heroTag: heroTag,),

          YBox(25),

          // price and increase quantity
          _PriceSection(),

          YBox(30),

          // product details
          _ProductDetails(),
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
              onPressed: () {},
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
  }
}

class _MedicationOverview extends StatelessWidget {

  final String heroTag;

  const _MedicationOverview({Key key, this.heroTag}) : super(key: key);

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
              kezitilSusp,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        YBox(5),
        Text(
          'Kezitil Susp',
        ),
        Text(
          'Soft Gel - 650mg',
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
                  'Emzor Pharmaceuticals',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceSection extends StatelessWidget {
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
                onPressed: () {},
              ),
              Text(
                '1',
              ),
              IconButton(
                splashRadius: 20,
                icon: Icon(Icons.add),
                onPressed: () {},
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
          '\u{20A6}385',
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
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
              value: '3x10',
            ),
            Spacer(),
            _ProductDetailsEntry(
              assetSrc: productId,
              info: 'PRODUCT ID',
              value: 'PROBYVPW1',
            ),
            Spacer(),
          ],
        ),
        _ProductDetailsEntry(
          assetSrc: pill,
          info: 'CONSTITUENTS',
          value: 'Garlic Oil',
        ),
        _ProductDetailsEntry(
          assetSrc: pillPack,
          info: 'DISPENSED IN',
          value: 'PACKS',
        ),
        YBox(20),
        Align(
          child: Text(
            '1 pack of Garlic Oil contains 3 unit(s) of 10 Tablet(s)',
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
