import 'package:flutter/material.dart';

class ReceiveRequestsScreen extends StatefulWidget {
  @override
  _ReceiveRequestsScreenState createState() => _ReceiveRequestsScreenState();
}
//استقبال الادمن طلب المساعده من الحاج
class _ReceiveRequestsScreenState extends State<ReceiveRequestsScreen> {
  String filter = "All Requests"; //By default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "RECEIVE REQUESTS",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            color: Colors.white,
            onSelected: (value) {
              setState(() {
                filter = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "All Requests", child: Text("All Requests")),
              PopupMenuItem(value: "Unanswered", child: Text("Unanswered Requests")),
              PopupMenuItem(value: "Answered", child: Text("Answered Requests")),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/request.png",
              height: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Text(
              "There are no requests",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
