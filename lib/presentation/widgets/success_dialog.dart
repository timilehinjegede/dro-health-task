import 'package:dro_health/logic/bag/cubit/bag_cubit.dart';
import 'package:dro_health/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessDialog extends StatelessWidget {
  final bool isRemoved;

  const SuccessDialog({Key key, this.isRemoved = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bagCubit = BlocProvider.of<BagCubit>(context);
    return Container(
      height: 300,
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
                      style: theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                YBox(20),
                Align(
                  child: Text(
                    '${bagCubit.state.bagItem.medication.name} has been ${isRemoved ? 'removed from' : 'added to'} your bag',
                    style: theme.textTheme.bodyText1.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
            translation: Offset(0, -4.4),
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
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600,
              color: whiteColor,
              fontSize: 15,
            ),
      ),
    );
  }
}
