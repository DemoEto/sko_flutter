import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// Widget ที่ 4: General Widget
class generalWidget extends StatelessWidget {
  const generalWidget({Key? key}) : super(key: key);

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
              color: const Color(0xFF4A7FD8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              context.tr("General"),
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
              _buildGeneralItem(Icons.people, context.tr("Share"), Colors.blue),
              _buildGeneralItem(Icons.calendar_today, context.tr("Guarantees"), Colors.red),
              _buildGeneralItem(Icons.store_mall_directory, context.tr("BalanceConfirm"), Colors.brown),
              _buildGeneralItem(Icons.calendar_month, context.tr("Meetings"), Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralItem(IconData icon, String label, Color color) {
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