import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:yusur_app/Screens/add_schedule.dart';
import 'package:yusur_app/Screens/campaign.dart';
import 'campaign_news_page.dart';

class CampaignSchedule extends StatefulWidget {
  const CampaignSchedule({super.key});

  @override
  State<CampaignSchedule> createState() => _CampaignScheduleState();
}

class _CampaignScheduleState extends State<CampaignSchedule> {
  List<Map<String, dynamic>> schedules = []; // 🔥 تخزين البيانات هنا
  int currentIndex = 0; // 🔥 تتبع العنصر المعروض

  @override
  void initState() {
    super.initState();
    fetchSchedules(); // 🔥 جلب البيانات عند فتح الصفحة
  }

  Future<void> fetchSchedules() async {
    final url = Uri.parse("https://code-builders.space/fluttertest/newgetsc.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        schedules = data.map((e) => {
          "id": e["id"],
          "date": e["date"],
          "details": e["details"]
        }).toList();
      });
    } else {
      print("❌ فشل في جلب البيانات");
    }
  }

  void showNextSchedule() {
    if (schedules.isNotEmpty) {
      setState(() {
        currentIndex = (currentIndex + 1) % schedules.length;
      });
    }
  }

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
          "Campaign Schedule",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffffD9D9D9), width: 1),
                color: Color.fromARGB(255, 241, 238, 238),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Campaign()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 367,
                      margin: EdgeInsets.fromLTRB(12, 60, 12, 1),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(
                          color: Color.fromARGB(128, 154, 145, 133),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/schedule.png",
                                  height: 25,
                                  width: 25,
                                ),
                                Text(
                                  "Schedule",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color.fromARGB(
                                      255,
                                      102,
                                      96,
                                      89,
                                    ),
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 100),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CampaignNews(),
                                ),
                              );
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/news.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  Text(
                                    "News",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: showNextSchedule, // 🔥 الضغط يعرض الحدث التالي
                      child: Column(
                        children: [
                          // ✅ مربع التاريخ
                          Container(
                            height: 51,
                            width: 307,
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            padding: EdgeInsets.only(left: 35, right: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(59),
                              border: Border.all(
                                color: Color.fromARGB(128, 154, 145, 133),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Image(image: AssetImage("images/arrow.png")),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    schedules.isNotEmpty
                                        ? '${schedules[currentIndex]["date"]}'
                                        : "Loading...",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10),

                          // ✅ مربع التفاصيل
                          Container(
                            width: 307,
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color.fromARGB(128, 154, 145, 133),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              schedules.isNotEmpty
                                  ? '${schedules[currentIndex]["details"]}'
                                  : "Loading...",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 183, 173, 159),
                    fixedSize: Size(60, 60),
                    padding: EdgeInsets.all(3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSchedulePage(),
                      ),
                    );
                  },
                  child: Icon(Icons.add, color: Colors.black, size: 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
