import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yusur_app/Screens/Home_page_two.dart';
import 'package:yusur_app/Screens/sign_in.dart';
import 'package:yusur_app/widget/InfoBottomSheet.dart';
import 'package:yusur_app/widget/arrow.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _login() async {
    final String pilgrimID = _idController.text.trim();
    final String password = _passwordController.text.trim();

    if (pilgrimID.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields.");
      return;
    }

    try {
      // البحث عن بيانات الحاج في Firestore
      final querySnapshot =
          await _firestore
              .collection('Pilgrim')
              .where('id', isEqualTo: pilgrimID)
              .where('password', isEqualTo: password)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageTwo(pilgrimID: pilgrimID),
          ),
        );
      } else {
        _showMessage("Pilgrim ID or password is incorrect.");
      }
    } catch (e) {
      _showMessage("An error occurred: $e");
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Ok"),
              ),
            ],
          ),
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
        elevation: 0,
        title: const Text(
          "Login",
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
        // زر المعلومات (i)
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffffD9D9D9), width: 1),
              color: Color.fromARGB(255, 241, 238, 238),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.info_outline, color: Colors.black),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder:
                      (context) => const InfoBottomSheet(
                        description:
                            "1. After joining a campaign, receive your ID and password.\n"
                            "2. Enter your ID and password to access your account.\n"
                            "3. Change details: Update your password.\n",
                      ),
                );
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 100),
          Column(
            children: [
              Image.asset("images/pligrimIcon.png"),
              SizedBox(height: 20),

              const Text(
                "Sign in to unlock exclusive features and personalize your Hajj experience.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Join the experience designed just for you.",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // حقول الادخال
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _idController,
                      decoration: InputDecoration(
                        labelText: "ID/Email",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(
                              0xFFB7AD9F,
                            ), //اللوناللي يطلع لما اضغط على الحقل
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFB7AD9F)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Are you campaign admin ?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Color.fromARGB(255, 150, 137, 119),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // زر الدخول
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB7AD9F),
                        padding: EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
