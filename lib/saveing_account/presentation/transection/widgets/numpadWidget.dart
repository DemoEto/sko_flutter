import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Numpadwidget extends StatefulWidget {
  const Numpadwidget({super.key});

  @override
  State<Numpadwidget> createState() => _NumpadwidgetState();
}

class _NumpadwidgetState extends State<Numpadwidget> {
  String _display = '';

  String formatNumber(String value) {
    if (value.isEmpty) return "";

    // เอา , ออกก่อน
    value = value.replaceAll(",", "");

    // ถ้ามีแต่จุด เช่น "."
    if (value == ".") return "0.";

    // ถ้ามีจุดทศนิยม
    if (value.contains(".")) {
      List<String> parts = value.split(".");
      String integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : "";

      if (integerPart.isEmpty) integerPart = "0";

      return "${_formatInteger(integerPart)}.$decimalPart";
    }

    return _formatInteger(value);
  }

  String _formatInteger(String value) {
    value = value.replaceAll(',', '');

    String result = "";
    int count = 0;

    for (int i = value.length - 1; i >= 0; i--) {
      result = value[i] + result;
      count++;

      if (count == 3 && i != 0) {
        result = "," + result;
        count = 0;
      }
    }
    return result;
  }

  void onNumberPressed(String num) {
    setState(() {
      // เอา , ออกก่อน
      String raw = _display.replaceAll(",", "");
      // ป้องกัน . ซ้ำ
      if (num == "." && raw.contains(".")) return;

      // ถ้ามีจุดแล้ว → จำกัดทศนิยม 2 ตำแหน่ง
      if (raw.contains(".")) {
        List<String> parts = raw.split(".");
        String decimal = parts[1];

        if (decimal.length >= 2) return; // ห้ามเกิน 2 ตำแหน่ง
      }
      // จำกัดจำนวนเต็ม 9 หลัก
      if (!raw.contains(".")) {
        if (raw.length >= 9) return;
      } else {
        // ถ้ามีจุด → ตรวจเฉพาะส่วน integer ก่อนหน้า
        List<String> parts = raw.split(".");
        if (parts[0].length >= 9 && num != ".") {
          // ยกเว้นปุ่ม "." เพราะไม่ใช่เลข
          return;
        }
      }
      // ห้ามกด 0 เป็นตัวแรก (ยกเว้นจะกด . ต่อ)
      if (raw.isEmpty && num == "0") return;
      if (raw == "0" && num != ".") return; // ป้องกัน 01, 02, 03

      raw += num;
      _display = formatNumber(raw);
    });
  }

  void onBackspace() {
    setState(() {
      if (_display.isEmpty) return;

      String raw = _display.replaceAll(",", "");

      raw = raw.substring(0, raw.length - 1);

      _display = formatNumber(raw);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   color: Colors.grey[800],
      //   borderRadius: BorderRadius.circular(20),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.5),
      //       blurRadius: 20,
      //       offset: const Offset(0, 10),
      //     ),
      //   ],
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.tr("Amount")),

          // Display
          Container(
            width: 300,
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // decoration: BoxDecoration(
            //   color: Colors.black87,
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _display.isEmpty ? '0.00' : _display,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A7FD8),
                  fontFamily: 'monospace',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          const SizedBox(height: 20),
          // Numpad buttons
          Column(
            children: [
              _buildButtonRow(['1', '2', '3']),
              // const SizedBox(height: 12),
              _buildButtonRow(['4', '5', '6']),
              // const SizedBox(height: 12),
              _buildButtonRow(['7', '8', '9']),
              // const SizedBox(height: 12),
              _buildBottomRow(),
              const SizedBox(height: 24),
              _nextButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((btn) => _buildButton(btn)).toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton('.'),
        const SizedBox(width: 0),
        _buildButton('0'),
        const SizedBox(width: 0),
        _buildButton('⌫'),
      ],
    );
  }

  Widget _buildButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        onPressed: () {
          if (label == '⌫') {
            onBackspace();
          } else {
            onNumberPressed(label);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          minimumSize: const Size(120, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(label, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 91, 127, 211),
          foregroundColor: Colors.white,
          minimumSize: const Size(300, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        child: Text(
          context.tr("Next"),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
