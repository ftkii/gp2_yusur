import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yusur_app/Screens/fatwa_screen.dart';
import 'package:yusur_app/Screens/manasik_screen.dart';
import 'package:yusur_app/Screens/prayer_time.dart';
import 'package:yusur_app/Screens/profile.dart';
import 'package:yusur_app/Screens/qibla_direction_screen.dart';
import 'package:yusur_app/Screens/regInfo.dart';
import 'package:yusur_app/Screens/sign_in.dart';
import 'package:yusur_app/widget/FeaturedServices.dart';
import 'package:yusur_app/widget/card.dart';
import 'package:yusur_app/widget/menu.dart';
import 'package:yusur_app/widget/nav_bar.dart';
import 'package:yusur_app/Screens/global.dart';

import 'quran/view_surah.dart'; // استدعاء المتغير العام

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  var widgetJsonData;

  loadJsonAssets() async {
    final String jsonString = await rootBundle.loadString(
      "assets/json/surahs.json",
    );
    var data = jsonDecode(jsonString);
    setState(() {
      widgetJsonData = data;
    });
    final String jsonString2 = await rootBundle.loadString(
      "assets/json/quarters.json",
    );
    var data2 = jsonDecode(jsonString2);
  }

  @override
  void initState() {
    loadJsonAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Sidebar(), // في له كلاس
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset("assets/images/yusur_logo.png", height: 60),
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          SizedBox(height: 50),
          //Card
          Card_ra(),
          SizedBox(height: 40),
          //Featured Services
          Text(
            "Featured Services",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          FeaturedService(
            items: [
              {
                'text': 'Quran',
                'image': 'assets/images/Vector.png',
                'page': ViewSurah(jsonData: widgetJsonData),
              },
              /* {
                'text': 'Profile',
                'image': 'assets/images/Profile.png',
                'page': Profile(),
              }, */
              {
                'text': 'Hajj & Umrah',
                'image': 'assets/images/Hajj.png',
                'page': Reginfo(),
              },
              {'text': 'Dua & Azkar', 'image': 'assets/images/Dua.png'},
              {'text': 'Zakat', 'image': 'assets/images/Zakat.png'},
              {
                'text': 'Qibla Direction',
                'image': 'assets/images/Qibla.png',
                'page': QiblaDirectionScreen(),
              },
              {'text': 'Map', 'image': 'assets/images/Map.png'},
              {
                'text': 'Prayer Time',
                'image': 'assets/images/Prayer.png',
                'page': PrayerTime(),
              },
              {
                'text': 'Fatwas',
                'image': 'assets/images/fatwas.png',
                'page': FatwaScreen(),
              },
              {
                'text': 'Manasik',
                'image': 'assets/images/Manasik.png',
                'page': ManasikScreen(),
              },
            ],
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
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Reginfo(), // صفحة معلومات التسجيل
              ),
            );
          }
        },
      ),
    );
  }
}
