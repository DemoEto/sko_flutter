import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sko_flutter/general/data/shareMonthlyListModel.dart';

class Sharelistwidget extends StatefulWidget {
  const Sharelistwidget({Key? key}) : super(key: key);

  @override
  State<Sharelistwidget> createState() => _SharelistwidgetState();
}

class _SharelistwidgetState extends State<Sharelistwidget> {
  final List<Item> allItems = [
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now().subtract(const Duration(days: 1)),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now().subtract(const Duration(days: 3)),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now().subtract(const Duration(days: 5)),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now().subtract(const Duration(days: 7)),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now(),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now().subtract(const Duration(days: 10)),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now().subtract(const Duration(days: 2)),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
    Item(
      title: 'ส่งหุ้นประจำเดือน',
      date: DateTime.now().subtract(const Duration(days: 15)),
      money: '500',
      period: '322',
      sharestock: '124124',
      receiptno: '43596093486',
    ),
  ];

  DateTime? startDate;
  DateTime? endDate;
  List<Item> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  // ฟังก์ชันกรองข้อมูลตามวันที่
  void filterByDate() {
    setState(() {
      if (startDate == null && endDate == null) {
        filteredItems = allItems;
      } else {
        filteredItems = allItems.where((item) {
          if (startDate != null && endDate != null) {
            return item.date.isAfter(
                  startDate!.subtract(const Duration(days: 1)),
                ) &&
                item.date.isBefore(endDate!.add(const Duration(days: 1)));
          } else if (startDate != null) {
            return item.date.isAfter(
              startDate!.subtract(const Duration(days: 1)),
            );
          } else if (endDate != null) {
            return item.date.isBefore(endDate!.add(const Duration(days: 1)));
          }
          return true;
        }).toList();
      }
    });
  }

  // เลือกวันที่เริ่มต้น
  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
      filterByDate();
    }
  }

  // เลือกวันที่สิ้นสุด
  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
      filterByDate();
    }
  }

  // รีเซ็ตฟิลเตอร์
  void resetFilter() {
    setState(() {
      startDate = null;
      endDate = null;
      filteredItems = allItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Column(
      children: [
        // ส่วนของ Date Filter
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.blue.shade50,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => selectStartDate(context),
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.green,
                      ),
                      label: Text(
                        startDate == null
                            ? context.tr("StartDate")
                            : dateFormat.format(startDate!),
                        style: TextStyle(color: Colors.green[800]),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => selectEndDate(context),
                      icon: const Icon(Icons.calendar_today, color: Colors.red),
                      label: Text(
                        endDate == null
                            ? context.tr("EndDate")
                            : dateFormat.format(endDate!),
                        style: TextStyle(color: Colors.red[800]),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (startDate != null || endDate != null)
                ElevatedButton.icon(
                  onPressed: resetFilter,
                  icon: const Icon(Icons.clear),
                  label: Text(context.tr("ClearFillter")),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                  ),
                ),
            ],
          ),
        ),

        // แสดงจำนวนรายการ
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            '${context.tr("Found")} ${filteredItems.length} ${context.tr("Items")} ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // ListView - ใช้ Expanded เพื่อให้ขยายเต็มพื้นที่ที่เหลือ
        Expanded(
          child: filteredItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.tr("NoDataForSelectedDates"),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              '${item.money} ${context.tr("THB")}',
                              style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 0),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  dateFormat.format(item.date),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            Text('${context.tr("Period")} : ${item.period}'),
                            Text(
                              '${context.tr("ShareAmt")} : ${item.sharestock}',
                            ),
                            Text(
                              '${context.tr("ReceiptNo")} : ${item.receiptno}',
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('คลิกที่ ${item.title}'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
