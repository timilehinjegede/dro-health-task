// format money
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
