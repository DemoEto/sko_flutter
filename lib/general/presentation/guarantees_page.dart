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
  final List<GuaranteesModel> youcallwho = [
    GuaranteesModel(
      title: 'youcallwho',
      contractno: 'สป6432422',
      loantype: 'เงินกู้สามัญใช้คนค้ำประกัน',
      loanbalance: 1483295.68,
      lastperiod: '56 / 306',
      memberno: '00004385',
      icon: Icons.savings,
      color: Colors.blue,
    ),
    GuaranteesModel(
      title: 'youcallwho',
      contractno: 'สป6432296',
      loantype: 'เงินกู้สามัญใช้คนค้ำประกัน',
      loanbalance: 3025734.68,
      lastperiod: '56 / 306',
      memberno: '00004386',
      icon: Icons.savings,
      color: Colors.indigo,
    ),
    GuaranteesModel(
      title: 'youcallwho',
      contractno: 'สป6498296',
      loantype: 'เงินกู้สามัญใช้คนค้ำประกัน',
      loanbalance: 4000000.00,
      lastperiod: '56 / 306',
      memberno: '00004387',
      icon: Icons.savings,
      color: Colors.deepPurple,
    ),
  ];

  final List<GuaranteesModel> whocallyou = [
    GuaranteesModel(
      title: 'whocallyou',
      contractno: 'สป6432230',
      loantype: 'เงินกู้สามัญใช้คนค้ำประกัน',
      loanbalance: 4000000.00,
      lastperiod: '56 / 306',
      memberno: '00004389',
      icon: Icons.savings,
      color: Colors.green,
    ),
    GuaranteesModel(
      title: 'whocallyou',
      contractno: 'สป6432230',
      loantype: 'เงินกู้สามัญใช้คนค้ำประกัน',
      loanbalance: 4000000.00,
      lastperiod: '56 / 306',
      memberno: '00004389',
      icon: Icons.savings,
      color: Colors.teal,
    ),
    GuaranteesModel(
      title: 'whocallyou',
      contractno: 'สป6432230',
      loantype: 'เงินกู้สามัญใช้คนค้ำประกัน',
      loanbalance: 4000000.00,
      lastperiod: '56 / 306',
      memberno: '00004389',
      icon: Icons.savings,
      color: Colors.lightGreen,
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
                  guarantees: youcallwho,
                  title: 'youcallwho',
                ),
                GuaranteesList(
                  animationController: _animationController,
                  guarantees: whocallyou,
                  title: 'whocallyou',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
