import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RecentlyActiveAccountsPage extends StatefulWidget {
  const RecentlyActiveAccountsPage({super.key});

  @override
  State<RecentlyActiveAccountsPage> createState() => _RecentlyActiveAccountsPageState();
}

class _RecentlyActiveAccountsPageState extends State<RecentlyActiveAccountsPage> {
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
              context.tr("TransferMyself"),
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
        children: [
          
        ],
      ),
    );
  }
}