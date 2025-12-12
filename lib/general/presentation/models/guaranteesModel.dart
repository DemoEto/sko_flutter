
import 'package:flutter/material.dart';

class GuaranteesModel {
  final String title;
  final String contractno;
  final String loantype;
  final double loanbalance;
  final String lastperiod;
  final String memberno;
  final IconData icon;
  final MaterialColor color;

  GuaranteesModel({
    required this.title,
    required this.contractno,
    required this.loantype,
    required this.loanbalance,
    required this.lastperiod,
    required this.memberno,
    required this.icon,
    required this.color,
  });

  String get formattedBalance {
    return '฿${loanbalance.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }
}
