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
            context.tr("ApplicationSettings"),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.language, size: 35, color: Colors.lightBlue),
                  SizedBox(width: 10,),
                  Text(context.tr("Langage"), style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (context.locale.languageCode == 'th') {
                        context.setLocale(const Locale('en'));
                      } else {
                        context.setLocale(const Locale('th'));
                      }
                    },
                    child: Text(
                      context.locale.languageCode == 'th'
                          ? 'เปลี่ยนเป็นภาษาอังกฤษ'
                          : 'Switch to Thai',style: TextStyle(color: Color(0xFF4A7FD8)),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(onPressed: onPressed, child: child)
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
