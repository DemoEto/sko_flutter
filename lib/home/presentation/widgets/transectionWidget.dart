import 'package:flutter/material.dart';
import 'package:sko_flutter/login/presentation/login_page.dart';

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
            child: const Text(
              'ธุรกรรม',
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
              _buildTransactionItem(Icons.wallet, 'จัดการบัญชี', Colors.green),
              _buildTransactionItem(
                Icons.phone_in_talk,
                'ชำระหุ้นหนี้',
                Colors.orange,
              ),
              _buildTransactionItem(Icons.store, 'ถอนเงินฝาก', Colors.blue),
              _buildTransactionItem(
                Icons.account_balance,
                'ฝากเงินเข้า\nบัญชิ',
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              _buildTransactionItem(
                Icons.account_balance_wallet,
                'โอนภายในบัญชีตัวเอง',
                Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(IconData icon, String label, Color color,) {
    return Column(
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
    );
  }
}
