import 'package:sko_flutter/general/presentation/widgets/shareListWidget.dart';

class Item {
  final String title;
  final DateTime date;
  final String money;
  final String period;
  final String sharestock;
  final String receiptno;

  Item({
    required this.title,
    required this.date,
    required this.money,
    required this.period,
    required this.sharestock,
    required this.receiptno,
  });
}