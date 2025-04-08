import 'package:flutter/material.dart';
import 'package:yusur_app/widget/arrow.dart';
import '/widget/faq_tile.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

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
          "FAQ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Expanded(
                child: ListView(
                  children: const [
                    FAQTile(
                      title: 'Can we read Quran in Yusur?',
                      content:
                          'Yes, you can read the Quran in the Yusr app. Just go to the "Featured Services" section and tap the "Quran" icon. You will then be able to start reading',
                    ),
                    const SizedBox(height: 5),
                    FAQTile(
                      title: 'How to accurately find Qibla?',
                      content:
                          'To accurately find the Qibla direction, look for the "Additional Services" section or similar, then tap the "Qibla Direction" icon. Follow the on-screen instructions',
                    ),
                    const SizedBox(height: 5),
                    FAQTile(
                      title: 'Daily Prayer Times?',
                      content:
                          'To find the daily prayer times, look for the "Additional Services" section or similar, then tap the "Prayer Times" icon. The app will then accurately display the daily prayer times.',
                    ),
                    const SizedBox(height: 5),
                    FAQTile(
                      title: 'How the Pilgrim Login in the App',
                      content:
                          'To log in, find the "Login" section, tap the "Login" icon, and enter your credentials. You must have a registered campaign to log in',
                    ),
                    const SizedBox(height: 5),
                    FAQTile(
                      title:
                          'How can I see the latest news and updates about my campaign?',
                      content:
                          'To view your campaign news, you must first log in to the app. Once logged in, go to the "Campaign News" section.',
                    ),
                    const SizedBox(height: 5),
                    FAQTile(
                      title:
                          'How can the campaign administrator add new pilgrims to the campaign?',
                      content:
                          'After creating your account as a campaign administrator, you can add new pilgrims through the "Add Pilgrims" section of the app.',
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
