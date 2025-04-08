import 'package:flutter/material.dart';
import 'package:yusur_app/widget/arrow.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({Key? key}) : super(key: key);

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  // قائمة أوقات الصلاة
  final List<Map<String, dynamic>> prayerTimes = [
    {"name": "Fajr", "time": "4:35 am"},
    {"name": "Dhuhr", "time": "11:40 am"},
    {"name": "Asr", "time": "2:58 pm"},
    {"name": "Maghrib", "time": "5:26 pm"},
    {"name": "Isha", "time": "6:56 pm"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Prayer Time",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16, top: 16),
            child: ArrowIcon(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            const Text(
              "Riyadh",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "Thursday, April 15",
              style: TextStyle(color: Colors.grey.shade700),
            ),

            const SizedBox(height: 30),

            // الوقت الحالي للصلاة
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFD9D9D9)),
              ),
              child: Column(
                children: [
                  // اسم ووقت الصلاة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Isha",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "6:56 pm",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Isha started",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        "58 min 6 sec",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            const Divider(indent: 20, endIndent: 20),
            const SizedBox(height: 40),

            // عرض قائمة أوقات الصلاة المتبقية
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                border: Border.all(color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // ظل خفيف
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: prayerTimes.map((prayer) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // اسم الصلاة
                            Text(
                              prayer["name"]!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            //وقت الصلاة
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: prayer["time"]!
                                        .split(" ")[0], // الوقت فقط
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " ${prayer["time"]!.split(" ")[1]}", // am/pm
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (prayer !=
                          prayerTimes.last) // إضافة خط فاصل بين الصلوات
                        Divider(
                          color: Colors.grey[350],
                          thickness: 1,
                          height: 1,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
