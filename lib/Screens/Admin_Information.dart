import 'package:flutter/material.dart';
import 'package:yusur_app/Screens/Home_page.dart';
import 'package:yusur_app/Screens/Home_page_two.dart';
import 'package:yusur_app/widget/Admin_info.dart';

import 'package:yusur_app/widget/nav_bar.dart';

class AdminInformation extends StatefulWidget {
  const AdminInformation({super.key});

  @override
  State<AdminInformation> createState() => _AdminInformationState();
}

class _AdminInformationState extends State<AdminInformation> {
  int selectedIndex = 1;
  Map<String, dynamic>? pilgrimData;
  bool isLoading = true;

  // تسجيل الخروج
  void logOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
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
          "Admin Information",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: logOut,
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          // التنقل بين الصفحات بناءً على التحديد
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePageTwo(pilgrimID: ''),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminInformation()),
            );
          }
        },
      ),

      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  SizedBox(height: 100),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "John Doe",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 400,
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xfff666059),
                              width: 0.5,
                            ),
                            color: Color(0xfffD1CCC4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 15),
                              Admin_info(text: "Campaign ID: 1234567890"),
                              Admin_info(text: "Campaign Name:  Yusser Hajj"),
                              Admin_info(text: "Mobile Number: +966123456789"),
                              Admin_info(text: "Email:Yussercam@gmail.com"),
                              Admin_info(text: "Country: Saudi Arabia"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}
