import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Formrequestwidget extends StatefulWidget {
  const Formrequestwidget({super.key});

  @override
  State<Formrequestwidget> createState() => _FormrequestwidgetState();
}

class _FormrequestwidgetState extends State<Formrequestwidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _cardtype(context),
        SizedBox(height: 20),
        _formsubmit(context),
      ],
    );
  }

  Widget _cardtype(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${context.tr("LoanType")} :',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                Text(
                  '${context.tr("Interest")} :',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                Text(
                  '${context.tr("MaximumLoan")} :',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${context.tr("LoanType")} :',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${context.tr("Interest")} :',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${context.tr("MaximumLoan")} :',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formsubmit(BuildContext context) {
    String? selectedValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: context.tr("AmountRequestLoan"),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // สีแรก
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' (${context.tr("Max")} ---- ${context.tr("THB")})',
                style: TextStyle(
                  color: Colors.orange, // สีที่สอง
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("PleaseEnterLoanReq")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: const Icon(Icons.money, color: Colors.green),
          ),
        ),
        SizedBox(height: 15),

        RichText(
          text: TextSpan(
            text: context.tr("NumberInstallments"),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // สีแรก
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' (${context.tr("Max")} ---- ${context.tr("Period")})',
                style: TextStyle(
                  color: Colors.orange, // สีที่สอง
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("PleaseEnterLoanReq")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: const Icon(
              Icons.calendar_month_rounded,
              color: Colors.orange,
            ),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 1',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo") + "1"),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 2',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo" + "2")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 3',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo" + "3")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 4',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo" + "4")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 5',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo" + "5")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 6',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo" + "6")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 7',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo" + "7")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(
          '${context.tr("GuarantorMemberNo")} 8',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("GuarantorMemberNo" + "8")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.userTie, color: Colors.brown),
          ),
        ),
        SizedBox(height: 15),

        Text(context.tr("ReceivingMoney"), style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("ReceivingMoney")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(Icons.download, color: Colors.blue),
          ),
        ),
        SizedBox(height: 15),

        Text(context.tr("Bank"), style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("Bank")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(
              FontAwesomeIcons.buildingColumns,
              color: Colors.purple[300],
            ),
          ),
        ),
        SizedBox(height: 15),

        Text(context.tr("AccountRecieve"), style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            label: Text(context.tr("AccountRecieve")),
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF4A7FD8),
                width: 2.0,
              ),
            ),
            prefixIcon: Icon(FontAwesomeIcons.wallet, color: Color(0xFF2ECC71)),
          ),
        ),
        SizedBox(height: 15),

        Text(context.tr("Objective"), style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: "เลือกประเภท",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: Icon(FontAwesomeIcons.solidStar, color: Colors.amber),
          ),
          value: selectedValue,
          items: [
            "เพื่อทชำระหนี้บัตรเครดิต",
            "ซื้อที่ดิน",
            "ซ่อมแซมบ้าน ต่อเติมบ้าน",
            "ซื้อบ้าน สร้างบ้าน",
            "ศึกษาต่อ",
            "เพื่อการศึกษาบุตร",
            "ค่ารักษาพยาบาล",
            "ลดการส่งต้นเงินกู้สามัญ",
            "สาธารณูปโภค",
            "เพื่อการศึกษา",
            "ศึกษา อบรม ดูงาน",
            "ระดัยปริญญาเอก",
            "ระดับปริญญาโท",
            "ระดับปริญญาตรี",
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) => setState(() => selectedValue = value),
        ),
        SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr("AmountReceived"),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  context.tr("... ${context.tr("THB")}"),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        FractionallySizedBox(
          widthFactor: 1,
          child: const Divider(thickness: 1, color: Colors.grey),
        ),
        Text(context.tr("EvidenceForRequests"), style: TextStyle(fontSize: 16)),
        SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              focusColor: Color.fromARGB(255, 88, 150, 255),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF4A7FD8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      context.tr("SalarySlip"),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF4A7FD8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      context.tr("BookBank"),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4A7FD8), Colors.blue],
            ),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Text(
            context.tr("Next"),
            style: TextStyle(
              fontSize: 18, 
              color: Colors.white,
              
              ),
          ),
        ),
      ],
    );
  }
}
