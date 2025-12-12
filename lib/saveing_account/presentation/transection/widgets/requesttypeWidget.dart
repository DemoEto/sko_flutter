import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Requesttypeformwidget extends StatelessWidget {
  final String type;

  const Requesttypeformwidget({
    Key? key,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Text(
            context.tr("RequestType"),
            style: TextStyle(fontSize: 16),
          ),
        ),
        _cardtype(context, '(11) เงินกู้สามัญเพื่อแก้ไขปัญหาหนี้สินของสมาชิก', '4.75%'),
        _cardtype(context, '(12) เงินกู้สามัญเพื่อซื้อรถยนต์ไฟฟ้า EV', '4.75%'),
        _cardtype(context, '(18) สามัญเพื่อผู้ประสบภัย', '4.50%'),
        _cardtype(context, '(21) สามัญใช้หุ้นค้ำประกัน', '5.75%'),
        _cardtype(context, '(24) สามัญใช้คนค้ำประกัน', '6.00%'),
        _cardtype(context, '(26) สามัญเพื่อการศึกษา', '4.50%'),
        _cardtype(context, '(29) สามัญใช้อสังหาริมทรัพย์ค้ำประกัน', '5.75%'),
        _cardtype(context, '(33) เงินกู้พิเศษเพื่อการเคหะ', '5.50%'),
        _cardtype(context, '(34) เงินกู้พิเศษเพื่อประกอบอาชีพ', '5.50%'),
        _cardtype(context, '(88) พิเศษ ATM', '5.75%'),
      ],
    );
  }

  Widget _cardtype(BuildContext context, String name, String interest) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // print("object");
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              SizedBox(height: 5),
              Text(
                'interest : ${interest}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
