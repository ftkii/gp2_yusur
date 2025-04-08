import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yusur_app/Screens/NewsPage.dart';

class Addnewpage extends StatefulWidget {
  const Addnewpage({super.key});

  @override
  State<Addnewpage> createState() => _AddnewpageState();
}

class _AddnewpageState extends State<Addnewpage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _insertNews() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    var url = Uri.parse("https://code-builders.space/fluttertest/insert_news.php"); // ضع رابط السيرفر
    var response = await http.post(url, body: {
      "title": title,
      "description": description,
    });

    var data = jsonDecode(response.body);
    if (data["success"] == true) {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewsPage()),

      );
      _titleController.clear();
      _descriptionController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${data["message"]}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(51, 154, 145, 133),
        title: Center(
          child: Text(
            "Insert News",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20),
            Image.asset("images/news.png", height: 78, width: 96),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(204, 183, 173, 159),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(61),
                      topRight: Radius.circular(61)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Container(
                      height: 67,
                      width: 357,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 154, 145, 133),
                              width: 1)),
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            hintText: 'The subject',
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 211,
                      width: 357,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 154, 145, 133),
                            width: 1),
                      ),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 6,
                        decoration: InputDecoration(
                            hintText: 'Description',
                            border: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                      ),
                    ),
                    SizedBox(height: 60),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 175, 165, 152),
                          fixedSize: Size(357, 60)),
                      onPressed: _insertNews,
                      child: Text(
                        "Publish",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
