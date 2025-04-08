import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yusur_app/Screens/Login_page.dart';
import 'package:yusur_app/widget/nav_bar.dart';

class Profile extends StatefulWidget {
  final String userEmail;

  Profile({required this.userEmail});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex = 1;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final url = Uri.parse("http://localhost/server/url/get_pilgrim.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["success"] &&
          data["users"] != null &&
          data["users"].isNotEmpty) {
        setState(() {
          userData = data["users"][0];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showError("No user data found!");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showError("Failed to load data!");
    }
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
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
        title: Text("Pilgrim Profile", style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: selectedIndex,
        onTabSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : userData == null
              ? Center(
                child: Text(
                  "No Data Found",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Image.asset("images/yusur_logo.png", height: 90, width: 90),
                    SizedBox(height: 20),
                    Text(
                      "Your Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // بيانات المستخدم
                    ProfileItem(
                      icon: Icons.campaign,
                      title: "Campaign",
                      value: userData!["campaign_name"] ?? "N/A",
                    ),
                    ProfileItem(
                      icon: Icons.person,
                      title: "Admin",
                      value: userData!["admin_name"] ?? "N/A",
                    ),
                    ProfileItem(
                      icon: Icons.phone,
                      title: "Phone",
                      value: userData!["phone"] ?? "N/A",
                    ),
                    ProfileItem(
                      icon: Icons.email,
                      title: "Email",
                      value: userData!["email"] ?? "N/A",
                    ),
                    ProfileItem(
                      icon: Icons.lock,
                      title: "Password",
                      value: "********",
                    ),

                    SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

// ✅ ودجت مخصصة لعرض بيانات المستخدم مع أيقونات
class ProfileItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ProfileItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
