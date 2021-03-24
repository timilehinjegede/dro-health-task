// format money
import 'package:dro_health/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

String formatMoney(int amount) {
  FlutterMoneyFormatter flutterMoneyFormatter = FlutterMoneyFormatter(
    amount: amount.toDouble(),
    settings: MoneyFormatterSettings(
      symbol: '\u{20A6}',
      fractionDigits: 0,
    ),
  );

  return flutterMoneyFormatter.output.symbolOnLeft;
}

Future<void> buildItemAddedDialog(BuildContext context,
    [bool isItemRemoved = false]) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'label',
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: SuccessDialog(
        isRemoved: isItemRemoved,
      ),
    ),
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
