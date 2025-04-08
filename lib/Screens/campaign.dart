import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yusur_app/Screens/Home_page_two.dart';
import 'package:yusur_app/Screens/ListOfPilgrimScreen.dart';
import 'package:yusur_app/Screens/campaign_schedule.dart';
import 'package:yusur_app/Screens/profile.dart';
import 'package:yusur_app/Screens/request_details_screen.dart';
import 'package:yusur_app/Screens/requests_list_screen.dart';
import 'package:yusur_app/widget/contain.dart';
import 'campaign_news_page.dart';

class Campaign extends StatelessWidget {
  const Campaign({super.key});

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
          "Campaign",
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
                    MaterialPageRoute(
                      builder: (context) => HomePageTwo(pilgrimID: ''),
                    ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CampaignSchedule(),
                              ),
                            );
                          },
                          child: contain(
                            imagePath: 'images/schedule.png',
                            imageName: 'Campaign Schedule',
                          ),
                        ),
                        SizedBox(width: 35),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampaignNews(),
                              ),
                            );
                          },
                          child: contain(
                            imagePath: 'images/news.png',
                            imageName: 'Campaign News',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 90),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const ListOfPilgrimScreen(),
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CampaignNews(),
                                ),
                              );
                            },
                            child: contain(
                              imagePath: 'assets/AlarmBracelet.png',
                              imageName: 'Recive Location',
                            ),
                          ),
                        ),
                        SizedBox(width: 35),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(userEmail: ""),
                              ),
                            );
                          },
                          child: contain(
                            imagePath: 'images/news2.png',
                            imageName: 'List Pilgrim',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
