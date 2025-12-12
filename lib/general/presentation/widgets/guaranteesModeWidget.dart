
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GuaranteesMode extends StatelessWidget {
  final PageController pageController;
  final Function(int) onPageSelected;

  const GuaranteesMode({
    Key? key,
    required this.pageController,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleButtonItem(
              pageController: pageController,
              index: 0,
              icon: Icons.account_balance,
              label: context.tr("YouCallWho"),
              activeColor: Colors.blue,
              onTap: () => onPageSelected(0),
            ),
          ),
          Expanded(
            child: _ToggleButtonItem(
              pageController: pageController,
              index: 1,
              icon: Icons.account_balance_wallet,
              label: context.tr("WhoCallYou"),
              activeColor: Colors.green,
              onTap: () => onPageSelected(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButtonItem extends StatelessWidget {
  final PageController pageController;
  final int index;
  final IconData icon;
  final String label;
  final MaterialColor activeColor;
  final VoidCallback onTap;

  const _ToggleButtonItem({
    Key? key,
    required this.pageController,
    required this.index,
    required this.icon,
    required this.label,
    required this.activeColor,
    required this.onTap,
  }) : super(key: key);

  bool _isActive(double pageValue) {
    if (index == 0) {
      return pageValue < 0.5;
    } else {
      return pageValue >= 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 0;
        if (pageController.hasClients) {
          value = pageController.page ?? 0;
        }
        final isActive = _isActive(value);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                      colors: [
                        activeColor[600]!,
                        activeColor[400]!,
                      ],
                    )
                  : null,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.grey[600],
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
