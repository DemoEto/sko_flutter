import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Sharestockwidgets extends StatelessWidget {
  const Sharestockwidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 800,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.tr("TBShareAmt")),
            SizedBox(height: 5),
            Text(
              "1,234,500.00",
              style: TextStyle(
                fontSize: 22,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr("ShareBeginYear"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        context.tr("ShareMonthly"),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(context.tr("1,234,500.00 ")),
                      Text(context.tr("500.00 ")),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text(context.tr("THB")), Text(context.tr("THB"))],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
