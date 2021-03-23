import 'package:dro_health/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final bool isRemoved;

  const SuccessDialog({Key key, this.isRemoved = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      color: transparentColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FractionalTranslation(
                  translation: Offset(0, 0.8),
                  child: Align(
                    child: Text(
                      'Successful',
                    ),
                  ),
                ),
                YBox(20),
                Text(
                  'Garlic Oil has been ${isRemoved ? 'removed' : 'added'} to your bag',
                ),
                YBox(15),
                _ActionButton(
                  title: 'View Bag',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                YBox(15),
                _ActionButton(
                  title: 'Done',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          FractionalTranslation(
            translation: Offset(0, -4.15),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: greenColor,
                border: Border.all(
                  width: 4,
                  color: whiteColor,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: whiteColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const _ActionButton({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: whiteColor,
      color: greenColor,
      height: 48,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: onPressed,
      child: Text(
        title,
      ),
    );
  }
}
