import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Requesttypewidget extends StatelessWidget {
  final String name;
  final String interest;

  const Requesttypewidget({
    Key? key,
    required this.name,
    required this.interest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
