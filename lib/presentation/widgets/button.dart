import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddItemToBagButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddItemToBagButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: SizedBox(
          height: 50,
          child: RaisedButton(
            textColor: whiteColor,
            color: purpleColor,
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  bag,
                  color: whiteColor,
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
    );
  }
}
