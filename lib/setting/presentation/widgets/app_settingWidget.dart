import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppSettingwidget extends StatelessWidget {
  const AppSettingwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Text(
                'Application Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.language, size: 35, color: Colors.lightBlue),
                  Text(context.tr("Langage"), style: TextStyle(fontSize: 16)),
                  ElevatedButton(onPressed: onPressed, child: child)
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // 80% ของหน้าจอ
              child: const Divider(color: Colors.grey, thickness: 1),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  const Icon(Icons.language, size: 35, color: Colors.lightBlue),
                  const Text('Langage', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // 80% ของหน้าจอ
              child: const Divider(color: Colors.grey, thickness: 1),
            ),
      ],
    );
  }
}