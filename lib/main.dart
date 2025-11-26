import 'package:flutter/material.dart';
import 'package:sko_flutter/login/presentation/login_page.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      startLocale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('th')],
      path: 'assets/translations',
      fallbackLocale: const Locale('th'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const LoginPage(),
    );
  }
}