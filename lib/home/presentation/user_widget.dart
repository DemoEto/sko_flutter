import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget titlename() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      const SizedBox(width: 20),
      SvgPicture.asset('assets/icons/memberinfo_user.svg',
        width: 60,
        height: 60,
      ),

      const SizedBox(width: 12),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "สวัสดี",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "ชื่อ - สกุล", //TODO: string name
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    ],
  );
}
