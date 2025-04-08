import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hijri/hijri_calendar.dart';
import 'package:yusur_app/Screens/campaign.dart';
import 'campaign_schedule.dart';
import 'add_news.dart';

class CampaignNews extends StatefulWidget {
  const CampaignNews({super.key});

  @override
  State<CampaignNews> createState() => _CampaignNewsState();
}
String toOrdinal(int number) =>
    (number >= 11 && number <= 13)
        ? '${number}th'
        : (number % 10 == 1)
        ? '${number}st'
        : (number % 10 == 2)
        ? '${number}nd'
        : (number % 10 == 3)
        ? '${number}rd'
        : '${number}th';



class _CampaignNewsState extends State<CampaignNews> {
  List newsList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      var url = Uri.parse("https://code-builders.space/fluttertest/get_news.php");
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

  void nextNews() {
    setState(() {
      if (newsList.isNotEmpty) {
        currentIndex = (currentIndex + 1) % newsList.length;
      }
    });
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
          "Campaign News",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Campaign()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              newsList.isEmpty
                  ? const CircularProgressIndicator()
                  : Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: const Color.fromARGB(128, 154, 145, 133),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      newsList[currentIndex]['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      newsList[currentIndex]['description'],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        newsList[currentIndex]['created_at'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: nextNews,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 183, 173, 159),
                  fixedSize: const Size(60, 60),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.black, size: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



