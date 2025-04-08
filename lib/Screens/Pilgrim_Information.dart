import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yusur_app/Screens/Home_page.dart';
import 'package:yusur_app/Screens/Home_page_two.dart';
import 'package:yusur_app/widget/Pligrim_info.dart';
import 'package:yusur_app/widget/nav_bar.dart';

class PilgrimInformation extends StatefulWidget {
  final String? pilgrimID;
  const PilgrimInformation({super.key, required this.pilgrimID});

  @override
  State<PilgrimInformation> createState() => _PilgrimInformationState();
}

class _PilgrimInformationState extends State<PilgrimInformation> {
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

  // استرجاع بيانات الحاج من Firestore
  void fetchPilgrimData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('Pilgrim').get().then((
        value,
      ) {
        value.docs.forEach((element) {
          if (element['id'] == widget.pilgrimID) {
            setState(() {
              pilgrimData = element.data() as Map<String, dynamic>?;
              isLoading = false;
            });
          }
        });
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPilgrimData();
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
          "Pilgrim Information",
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
              MaterialPageRoute(
                builder: (context) => PilgrimInformation(pilgrimID: '18'),
              ),
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
                        pilgrimData != null
                            ? "${pilgrimData?['name']}"
                            : "Data not available",
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
                              pligrim_info(
                                text:
                                    pilgrimData != null
                                        ? "National ID / Iqama ID: ${pilgrimData!['id']}"
                                        : "Data not available",
                              ),
                              pligrim_info(
                                text:
                                    pilgrimData != null
                                        ? "Campaign: ${pilgrimData!['campaign']}"
                                        : "Data not available",
                              ),
                              pligrim_info(
                                text:
                                    pilgrimData != null
                                        ? "Mobile Number: ${pilgrimData!['phone']}"
                                        : "Data not available",
                              ),
                              pligrim_info(
                                text:
                                    pilgrimData != null
                                        ? "Blood Type: ${pilgrimData!['bloodType']}"
                                        : "Data not available",
                              ),
                              pligrim_info(
                                text:
                                    pilgrimData != null
                                        ? "Country: ${pilgrimData!['country']}"
                                        : "Data not available",
                              ),
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
