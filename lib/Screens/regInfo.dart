import 'package:flutter/material.dart';
import 'package:yusur_app/Screens/Home_page.dart';
import 'package:yusur_app/Screens/Login_page.dart';
import 'package:yusur_app/widget/nav_bar.dart';

class Reginfo extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Reginfo> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Profile"),
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            Image.asset("images/yusur_logo.png", height: 90, width: 90),
            SizedBox(height: 15),
            Text(
              "Easier and Safer Hajj at Your Fingertips!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 30),
            Text(
              "Enjoy exclusive services such as instant emergency assistance and other features designed to make your journey more comfortable. Registration is only available for pilgrims enrolled in an accredited Hajj campaign, ensuring access to additional benefits that enhance your experience with ease and peace of mind.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 40),
            Text(
              "If you are registered in a campaign, join now and take advantage of our exclusive services!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB7AD9F),
                padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
