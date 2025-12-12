import 'package:flutter/material.dart';
import '../../models/accountModel.dart';
import 'compactAccountCardWidget.dart';
import 'addCoopAccountButtonWidget.dart';

class AccountList extends StatelessWidget {
  final AnimationController animationController;
  final List<AccountModel> accounts;
  final String title;

  const AccountList({
    Key? key,
    required this.animationController,
    required this.accounts,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Opacity(
          opacity: 0.99 + (animationController.value * 0.01),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: accounts.length + 1,
              itemBuilder: (context, index) {
                if (index == accounts.length) {
                  // ถ้าเป็นบัญชีสหกรณ์ → แสดงปุ่มเพิ่มบัญชีสหกรณ์
                  if (title == "บัญชีสหกรณ์") {
                    return Addcoopaccountbuttonwidget(
                      onTap: () {
                        showAccountDetails(context);
                      },
                    );
                  }

                  // ถ้าเป็นบัญชีธนาคาร
                  if (title == "บัญชีธนาคาร") {
                    // return Addbankaccountbuttonwidget(
                    //   onTap: () {
                        
                    //   },
                    // );
                  }

                  return const SizedBox.shrink(); // กัน error
                }
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: CompactAccountCard(account: accounts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
    
  }
  
  void showAccountDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[400]!,
              Colors.green[600]!,
            ],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
