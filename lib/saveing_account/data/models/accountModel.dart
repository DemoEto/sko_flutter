
import 'package:flutter/material.dart';

class AccountModel {
  final String title;
  final String accountNumber;
  final double balance;
  final IconData icon;
  final MaterialColor color;

  AccountModel({
    required this.title,
    required this.accountNumber,
    required this.balance,
    required this.icon,
    required this.color,
  });

  String get formattedBalance {
    return '฿${balance.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }
}
