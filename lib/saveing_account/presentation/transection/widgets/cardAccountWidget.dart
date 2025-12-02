import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Cardaccountwidget extends StatefulWidget {
  const Cardaccountwidget({super.key});

  @override
  State<Cardaccountwidget> createState() => _CardaccountwidgetState();
}

class _CardaccountwidgetState extends State<Cardaccountwidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(30),
      child: Column(
        children: [
          //-- Top section
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            onTap: () {},
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ออมทรัพย์",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4A7FD8),
                        ),
                      ), //
                      Text(
                        "xxx-00-015xx",
                        style: TextStyle(
                          // color: Color(0xFF4A7FD8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(context.tr("WithdrawableAmtTHB")), //
                      Text(
                        "62,344.92",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF4A7FD8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //-- Line sprit horizontal
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(thickness: 1, color: Colors.grey, endIndent: 10),
              ),
              Icon(
                Icons.compare_arrows_rounded,
                color: Colors.red,
                fontWeight: FontWeight.w700,
                size: 35,
              ),
              Expanded(
                child: Divider(thickness: 1, color: Colors.grey, indent: 10),
              ),
            ],
          ),

          //-- Buttom section
          InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            onTap: () {},
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle,color: Colors.grey[350],size: 60,),
                  SizedBox(width: 10,),
                  Text(context.tr("pleaseSelectDestinationAccount"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
