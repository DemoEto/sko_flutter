import 'package:flutter/material.dart';
import 'package:sko_flutter/home/presentation/widgets/titlenameWidget.dart';
import 'package:sko_flutter/home/presentation/widgets/walletWidget.dart';
import 'package:sko_flutter/home/presentation/widgets/transectionWidget.dart';
import 'package:sko_flutter/home/presentation/widgets/generalWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const[
              titlenameWidget(),
              SizedBox(height: 20),

              // ส่วนที่ 2: Wallet Section
              walletWidget(),

              SizedBox(height: 20),

              // ส่วนที่ 3: Transaction Section
              transactionWidget(),

              SizedBox(height: 20),

              // ส่วนที่ 4: General Section
              generalWidget(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
