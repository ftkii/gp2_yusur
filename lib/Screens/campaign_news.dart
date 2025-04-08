import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/Screens/schedulecampaign.dart';
import '/widget/arrow.dart';

class CampaignNews extends StatefulWidget {
  const CampaignNews({super.key});

  @override
  _CampaignNewsState createState() => _CampaignNewsState();
}

class _CampaignNewsState extends State<CampaignNews> {
  List newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      var url = Uri.parse(
          "https://code-builders.space/fluttertest/get_news.php");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          newsList = json.decode(response.body);
        });
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  // زر الجدولة و الأخبار
                  _buildNavigationButtons(context),
                  const SizedBox(height: 45),
                  // عرض الأخبار من قاعدة البيانات
                  newsList.isEmpty
                      ? const Center(
                      child: CircularProgressIndicator()) // تحميل البيانات
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return _buildNewsCard(
                        newsList[index]['title'],
                        newsList[index]['description'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Container(
      width: 299,
      height: 64,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 249, 246, 246),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color.fromARGB(255, 221, 213, 213)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 16,
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Schedulecampaign()));
              },
              child: Center(
                child: Image.asset('images/schedule.png', width: 25,
                    height: 25,
                    fit: BoxFit.contain),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 38, left: 24),
            child: Text(
              " Schedule",
              style: TextStyle(color: Colors.black,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Positioned(
            top: 10,
            right: 35,
            child: Center(
              child: Image.asset('images/news.png', width: 25,
                  height: 25,
                  fit: BoxFit.contain),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 38, left: 234),
            child: Text(
              "News",
              style: TextStyle(color: Colors.black,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String description) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFB7AD9F), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر للأعلى
        children: [
          Image.asset('images/news2.png', width: 50, height: 50),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // محاذاة النص لليسار
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow
                      .ellipsis, // إضافة "..." عند تجاوز النص للطول المحدد
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}