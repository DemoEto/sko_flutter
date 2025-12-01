import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'accountListWidget.dart';

class Addcoopaccountbuttonwidget extends StatelessWidget {
  final VoidCallback onTap;
  const Addcoopaccountbuttonwidget({Key? key, required this.onTap,}) //?required this.accounts,
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final addText = accounts.contains('สหกรณ์')
    //     ? context.tr("AddCoopAccount")
    //     : context.tr("AddBankAccount");

    // return Container(
    //   margin: const EdgeInsets.only(bottom: 12),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(16),
    //     border: Border.all(color: const Color(0xFF4A7FD8), width: 1.5),
    //   ),
    //   child: Material(
    //     color: Colors.transparent,
    //     child: InkWell(
    //       borderRadius: BorderRadius.circular(16),
    //       onTap: onTap,
    //       child: Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: Row(
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.all(12),
    //               decoration: BoxDecoration(
    //                 color: const Color(0xFF4A7FD8).withOpacity(0.15),
    //                 borderRadius: BorderRadius.circular(12),
    //               ),
    //               child: const Icon(
    //                 Icons.add,
    //                 color: Color(0xFF4A7FD8),
    //                 size: 28,
    //               ),
    //             ),
    //             const SizedBox(width: 16),
    //             const Expanded(
    //               child: Text(
    //                 "เพิ่มบัญชีออมทรัพย์",
    //                 style: TextStyle(
    //                   color: Color(0xFF4A7FD8),
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             const Icon(
    //               Icons.arrow_forward_ios,
    //               color: Color(0xFF4A7FD8),
    //               size: 18,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A7FD8).withOpacity(0.6),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Color(0xFF4A7FD8)),
              SizedBox(width: 8),
              Text(
                context.tr("AddCoopAccount"),
                style: TextStyle(color: Color(0xFF4A7FD8), fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 10),
  //     child: InkWell(
  //       onTap: () {

  //       },
  //       child: Container(
  //             padding: const EdgeInsets.all(15),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(15),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.1),
  //                   spreadRadius: 1,
  //                   blurRadius: 5,
  //                 ),
  //               ],
  //             ),
  //             child: Row(
  //               children: [
  //                 Icon(Icons.add_box_rounded),Text(context.tr("AddCoopAccount"))
  //               ],
  //             ),
  //           ),
  //     ),
  //   );
  // }
}
