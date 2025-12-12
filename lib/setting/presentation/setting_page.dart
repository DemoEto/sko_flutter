import 'package:flutter/material.dart';
import 'package:sko_flutter/setting/presentation/widgets/titleWidget.dart';
import 'package:sko_flutter/setting/presentation/widgets/app_settingWidget.dart';
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleWidget(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            AppSettingwidget(),
            
          ],
        ),
      ),
    );
  }
}
