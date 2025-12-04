import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sko_flutter/general/presentation/widgets/shareListWidget.dart';
import 'widgets/shareStockWidgets.dart';

class Item {
  final String title;
  final String description;
  final DateTime date;

  Item({required this.title, required this.description, required this.date});
}

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF4A7FD8),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              context.tr("Share"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Sharestockwidgets(),
          Expanded(child: Sharelistwidget()),
        ],
      ),
    );
  }
}
