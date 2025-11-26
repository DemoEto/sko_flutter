import 'package:flutter/material.dart';
import 'package:sko_flutter/saveing_account/presentation/saving_account_page.dart';
import 'package:sko_flutter/saveing_account/presentation/recently_active_accounts_page.dart';
import 'package:sko_flutter/loan_contract/presentation/loan_contract_page.dart';
import 'package:sko_flutter/loan_contract/presentation/recently_active_loanaccounts_page.dart';
import 'package:easy_localization/easy_localization.dart';


class walletWidget extends StatelessWidget {
  const walletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildWalletCard(
            context.tr("TotalDeposits"),
            context.tr("Account_count"), //todo: show number of saving account
            [
              _buildIconButton(context, Icons.wallet, context.tr("ViewAccount"), Colors.purple, const SavingAccountPage()),
              _buildIconButton(context, Icons.phone_android, context.tr("RecentTransactions"), Colors.pink, const RecentlyActiveAccountsPage()),
            ],
          ),
          const SizedBox(height: 15),
          _buildWalletCard(
            context.tr("TotalDebt"),
            context.tr("DebtContract_count"), //todo: show number of contract
            [
              _buildIconButton(context, Icons.content_paste_search_outlined, context.tr("ViewLoanContract"), Colors.blue, const LoanContractPage()),
              _buildIconButton(context, Icons.phone_android, context.tr("RecentTransactions"), Colors.pink, const RecentlyActiveLoanaccountsPage()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard(String title, String subtitle, List<Widget> actions) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: actions,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String label, Color color, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 60,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9),
              maxLines: 2,
            ),
          ),
        ],
      ),
      ) 
    );
  }
}