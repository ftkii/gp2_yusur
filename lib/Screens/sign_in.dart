import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yusur_app/Screens/Home_page.dart';
import 'package:yusur_app/Screens/insertPilgrim.dart';

import 'package:yusur_app/Screens/Login_page.dart';
import 'package:yusur_app/Screens/add_news.dart';
import 'package:yusur_app/Screens/add_schedule.dart';
import 'package:yusur_app/Screens/help_request_screen.dart';
import 'package:yusur_app/Screens/ListOfPilgrimScreen.dart';
import 'package:yusur_app/Screens/campaign_news.dart';
import 'package:yusur_app/Screens/campaign_schedule.dart';
import 'sign_in_verify.dart';
import 'package:yusur_app/Screens/global.dart'; // استدعاء المتغير العام

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    const String apiUrl =
        "http://192.168.100.76/server/url/login.php"; // ضع رابط API هنا
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    setState(() {
      isLoading = false;
    });

    if (responseData["status"] == "success") {
      userEmail = emailController.text.trim(); // حفظ البريد الإلكتروني

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CampaignSchedule()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(responseData["message"])));
    }
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
          "Sign in",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 60),
              Image.asset("images/admainIcon.png", height: 83, width: 79),
              SizedBox(height: 10),
              Text(
                "Log in now to access exclusive features and manage your campaign effortlessly and efficiently.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildTextField(emailController, "Email"),
              SizedBox(height: 20),
              _buildTextField(
                passwordController,
                "Password",
                obscureText: true,
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 175, 165, 152),
                      fixedSize: Size(357, 60),
                    ),
                    onPressed: login,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    bool obscureText = false,
  }) {
    return Container(
      height: 60,
      width: 357,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color.fromARGB(255, 154, 145, 133), width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }
}
