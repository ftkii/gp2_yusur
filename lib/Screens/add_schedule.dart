import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yusur_app/Screens/schedulecampaign.dart';
import 'dart:convert';

import 'campaign_schedule.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  /// **📌 دالة لفتح التقويم واختيار التاريخ**
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // أول تاريخ يمكن اختياره
      lastDate: DateTime(2100), // آخر تاريخ يمكن اختياره
    );

    if (pickedDate != null) {
      String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  /// **📌 دالة لإرسال الجدول إلى قاعدة البيانات**
  Future<void> _insertSchedule() async {
    String details = _detailsController.text.trim();
    String date = _dateController.text.trim();

    if (details.isEmpty || date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    try {
      var url = Uri.parse("https://code-builders.space/fluttertest/insert_schedule.php");
      var response = await http.post(
        url,
        body: {
          "details": details,
          "date": date,
        },
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Schedule added successfully")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Schedulecampaign()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to insert schedule")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(51, 154, 145, 133),
        title: Center(
          child: Text(
            "Insert Schedule",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20),
            Image.asset("images/schedule.png", height: 83, width: 79),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(204, 183, 173, 159),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(61),
                      topRight: Radius.circular(61)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Container(
                      height: 211,
                      width: 357,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 154, 145, 133),
                              width: 1)),
                      child: TextField(
                        controller: _detailsController,
                        decoration: InputDecoration(
                            hintText: 'Enter the schedule details here.',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18)),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: Container(
                          height: 67,
                          width: 357,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromARGB(255, 154, 145, 133),
                                  width: 1)),
                          child: TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                                hintText: 'Select Date',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 18)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 175, 165, 152),
                          fixedSize: Size(357, 60)),
                      onPressed: _insertSchedule,
                      child: Text(
                        "Publish",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
