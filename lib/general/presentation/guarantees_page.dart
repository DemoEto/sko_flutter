import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/guaranteesModeWidget.dart';
import '../data/models/guaranteesModel.dart';
import 'widgets/guaranteesListWidget.dart';

class GuaranteesPage extends StatefulWidget {
  const GuaranteesPage({Key? key}) : super(key: key);

  @override
  State<GuaranteesPage> createState() => _GuaranteesPageState();
}

class _GuaranteesPageState extends State<GuaranteesPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;

  // ข้อมูลบัญชีต่างๆ
  final List<GuaranteesModel> coopAccounts = [
    GuaranteesModel(
      title: 'บัญชีออมทรัพย์',
      accountNumber: '001-2-34567-8',
      balance: 125450.00,
      icon: Icons.savings,
      color: Colors.blue,
    ),
    GuaranteesModel(
      title: 'บัญชีเงินฝากประจำ',
      accountNumber: '001-3-45678-9',
      balance: 500000.00,
      icon: Icons.account_balance,
      color: Colors.indigo,
    ),
    GuaranteesModel(
      title: 'บัญชีหุ้น',
      accountNumber: '001-4-56789-0',
      balance: 85000.00,
      icon: Icons.trending_up,
      color: Colors.purple,
    ),
  ];

  final List<GuaranteesModel> bankAccounts = [
    GuaranteesModel(
      title: 'บัญชีออมทรัพย์',
      accountNumber: '123-4-56789-0',
      balance: 89320.50,
      icon: Icons.account_balance_wallet,
      color: Colors.green,
    ),
    GuaranteesModel(
      title: 'บัญชีกระแสรายวัน',
      accountNumber: '123-5-67890-1',
      balance: 45600.00,
      icon: Icons.payment,
      color: Colors.teal,
    ),
    GuaranteesModel(
      title: 'บัญชีเงินฝากประจำ',
      accountNumber: '123-6-78901-2',
      balance: 1200000.00,
      icon: Icons.lock_clock,
      color: Colors.cyan,
    ),
  ];


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _switchToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _animationController.forward(from: 0);
  }

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
              context.tr("Guarantees"),
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
          // ปุ่มสลับ
          GuaranteesMode(
            pageController: _pageController,
            onPageSelected: _switchToPage,
          ),

          // เนื้อหาหน้า
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
                _animationController.forward(from: 0);
              },
              children: [
                GuaranteesList(
                  animationController: _animationController,
                  accounts: coopAccounts,
                  title: 'บัญชีสหกรณ์',
                ),
                GuaranteesList(
                  animationController: _animationController,
                  accounts: bankAccounts,
                  title: 'บัญชีธนาคาร',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
