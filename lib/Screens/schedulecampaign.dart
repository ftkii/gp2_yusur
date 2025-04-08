import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/Screens/campaign_news.dart';
import '/widget/arrow.dart';

class Schedulecampaign extends StatefulWidget {
  @override
  _SchedulecampaignState createState() => _SchedulecampaignState();
}

class _SchedulecampaignState extends State<Schedulecampaign> {
  String selectedDate = "Select Schedule"; // نص افتراضي للزر
  String details = ""; // تفاصيل الجدول المختار

  List<Map<String, dynamic>> schedules = []; // قائمة الجداول من قاعدة البيانات

  /// **📌 جلب جميع الـ Schedules من قاعدة البيانات**
  Future<void> fetchSchedules() async {
    try {
      var url = Uri.parse("https://code-builders.space/fluttertest/get_schedules.php");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          schedules = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      print("Error fetching schedules: $e");
    }
  }

  /// **📌 عرض قائمة الـ Schedules في `BottomSheet`**
  void showSchedulesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: schedules.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(schedules[index]['date']),
                subtitle: Text(schedules[index]['details']),
                onTap: () {
                  setState(() {
                    selectedDate = schedules[index]['date'];
                    details = schedules[index]['details'];
                  });
                  Navigator.pop(context); // إغلاق الـ BottomSheet
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchSchedules(); // تحميل الجداول عند فتح الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Campaign",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/wallepaper.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 120),
                    Container(
                      width: 299,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFB7AD9F)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 13,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CampaignNews()),
                                );
                              },
                              child: Center(
                                child: Image.asset(
                                  'images/news.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 16,
                            child: TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Image.asset(
                                  'images/schedule.png',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 38, left: 24),
                            child: Text(
                              "Schedule",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 38, left: 234),
                            child: Text(
                              "News",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 45),
                    GestureDetector(
                      onTap: () => showSchedulesBottomSheet(context),
                      child: Container(
                        width: 260,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0xFFB7AD9F)),
                        ),
                        child: Center(
                          child: Text(
                            selectedDate,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 295,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFB7AD9F)),
                      ),
                      child: Center(
                        child: Text(
                          details.isEmpty ? "Select a schedule to view details" : details,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
