import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sko_flutter/saveing_account/presentation/transection/deposit_page.dart';
import 'package:sko_flutter/saveing_account/presentation/transection/manage_account_page.dart';
import 'package:sko_flutter/saveing_account/presentation/transection/pay_debt_page.dart';
import 'package:sko_flutter/saveing_account/presentation/transection/withdraw_page.dart';
import 'package:sko_flutter/saveing_account/presentation/transection/transfer_ownaccount_page.dart';

class transactionWidget extends StatelessWidget {
  const transactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              context.tr("Transactions"),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTransactionItem(context,Icons.wallet, context.tr("ManageAccount"), Colors.green, const ManageAccountPage()),
              _buildTransactionItem(
                context,Icons.phone_in_talk,
                context.tr("PayShareDebt"),
                Colors.orange,const PayDebtPage()
              ),
              _buildTransactionItem(context,Icons.store, context.tr("WithdrawDeposites"), Colors.blue,const WithdrawPage()),
              _buildTransactionItem(
                context,Icons.account_balance,
                context.tr("DepositAccount"),
                Colors.orange,const DepositPage()
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              _buildTransactionItem(
                context,Icons.account_balance_wallet,
                context.tr("TransferMyself"),
                Colors.teal,const TransferOwnaccountPage()
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context,IconData icon, String label, Color color,Widget page) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:(context) => page,
            )
          );
        },
    child: Column(
      children: [
        Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
            maxLines: 2,
          ),
        ),
      ],
    ));
  }
}
