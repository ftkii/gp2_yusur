import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected; // استخدم دالة لتحديث الـ selectedIndex

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      child: GNav(
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 164, 162, 162),
        activeColor: Color.fromARGB(255, 91, 91, 91),
        tabBackgroundColor: const Color(0xFFB7AD9F),
        padding: const EdgeInsets.all(18),
        gap: 8,
        selectedIndex: selectedIndex,
        onTabChange: (index) {
          onTabSelected(index); // تغيير الصفحة بناءً على الاختيار
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.person,
            text: "Profile",
          ),
        ],
      ),
    );
  }
}
