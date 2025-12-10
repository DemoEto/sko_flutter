import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/requesttypeWidget.dart';

class FormRequestLoanPage extends StatelessWidget {
  const FormRequestLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[50],
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
              context.tr("FormRequestLoanOnline"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: 800,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: Text(
                    context.tr("RequestType"),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Requesttypewidget(
                  name:'(11) เงินกู้สามัญเพื่อแก้ไขปัญหาหนี้สินของสมาชิก',
                  interest: '4.75%',
                ),
                Requesttypewidget(
                  name:'(12) เงินกู้สามัญเพื่อซื้อรถยนต์ไฟฟ้า EV',
                  interest: '4.50%',
                ),
                Requesttypewidget(
                  name:'(18) สามัญเพื่อผู้ประสบภัย',
                  interest: '4.50%',
                ),
                Requesttypewidget(
                  name:'(21) สามัญใช้หุ้นค้ำประกัน',
                  interest: '5.75%',
                ),
                Requesttypewidget(
                  name:'(24) สามัญใช้คนค้ำประกัน',
                  interest: '6.00%',
                ),
                Requesttypewidget(
                  name:'(26) สามัญเพื่อการศึกษา',
                  interest: '4.50%',
                ),
                Requesttypewidget(
                  name:'(29) สามัญใช้อสังหาริมทรัพย์ค้ำประกัน',
                  interest: '5.75%',
                ),
                Requesttypewidget(
                  name:'(33) เงินกู้พิเศษเพื่อการเคหะ',
                  interest: '5.50%',
                ),
                Requesttypewidget(
                  name:'(34) เงินกู้พิเศษเพื่อประกอบอาชีพ',
                  interest: '5.50%',
                ),
                Requesttypewidget(
                  name:'(88) พิเศษ ATM',
                  interest: '5.75%',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
      
      
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Padding(
      //       padding: EdgeInsetsGeometry.all(20),
      //       child: Text(
      //         context.tr("RequestType"),
      //         style: TextStyle(fontSize: 16),
      //       ),
      //     ),Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
      //     child: Row(children: [Requesttypewidget()]),
      //     )
