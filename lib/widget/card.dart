import 'package:flutter/material.dart';
import 'dart:async';

class Card_ra extends StatefulWidget {
  const Card_ra({super.key});

  @override
  _Card_raState createState() => _Card_raState();
}

class _Card_raState extends State<Card_ra> {
  List<String> adhkar = [
    "Remember Allah",
    "Allah, send blessings and peace upon our Prophet Muhammad.",
    "SubhanAllah, Alhamdulillah, Allahu Akbar",
    "La ilaha illallah",
    "Bismillah",
    "Astaghfirullah",
  ];

  int currentIndex = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // تغيير الأذكار كل 15 ثانية
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % adhkar.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Remember Allah", style: TextStyle(fontSize: 13)),
            Text(
              adhkar[currentIndex],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffffD9D9D9), width: 1),
        color: Color.fromARGB(255, 243, 243, 243),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
