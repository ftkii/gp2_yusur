import 'package:flutter/material.dart';
import 'package:yusur_app/Screens/faq_page.dart';
import '/Screens/support.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Image.asset(
            "images/yusur_logo.png",
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("FAQ"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FAQScreen(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.headset_mic_outlined),
            title: Text("Support"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => support(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
