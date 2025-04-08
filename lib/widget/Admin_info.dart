import 'package:flutter/material.dart';

class Admin_info extends StatelessWidget {
  const Admin_info({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfff9A9185), width: 0.5),
          color: Color(0xfffFAF8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
