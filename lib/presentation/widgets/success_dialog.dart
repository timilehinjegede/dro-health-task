import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Successful',
          ),
          Text(
            'Garlic Oil has been added to your bag',
          ),
          _ActionButton(
            title: 'View Bag',
            onPressed: () {},
          ),
          YBox(15),
          _ActionButton(
            title: 'Done',
            onPressed: () {},
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
      height: 50,
      minWidth: double.infinity,
      onPressed: onPressed,
      child: Text(
        title,
      ),
    );
  }
}
