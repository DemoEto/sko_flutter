import 'package:flutter/material.dart';
import 'package:sko_flutter/setting/presentation/widgets/titleWidget.dart';
import 'package:sko_flutter/setting/presentation/widgets/app_settingWidget.dart';
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //-- Account Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Text(
                'Account Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            AppSettingwidget(),

            //-- Application Settings
            
          ],
        ),
      ),
    );
  }
}
