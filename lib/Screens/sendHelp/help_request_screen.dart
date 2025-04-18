import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:yusur_app/Screens/campaign.dart';
import 'requests_list_screen.dart'; // صفحة الطلبات

class HelpRequestScreen extends StatefulWidget {
  @override
  _HelpRequestScreenState createState() => _HelpRequestScreenState();
}

class _HelpRequestScreenState extends State<HelpRequestScreen> {
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  Location location = Location();

  Future<void> _requestHelp() async {
    if (_nameController.text.isEmpty) {
      _showDialog("Error", "Please enter your name");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      LocationData userLocation = await _getLocation();
      String latitude = userLocation.latitude.toString();
      String longitude = userLocation.longitude.toString();
      String locationText = "$latitude, $longitude";

      final url = Uri.parse(
        "https://code-builders.space/fluttertest/add_request.php",
      );
      final response = await http.post(
        url,
        body: {"user_name": _nameController.text, "location": locationText},
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData["status"] == "success") {
        _showDialog(
          "Success",
          responseData["message"] ?? "Operation successful",
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Campaign()),
        );
      } else {
        _showDialog("Error", responseData["message"] ?? "Unknown error");
      }
    } catch (error) {
      _showDialog("Error", "Failed to get location or send request.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<LocationData> _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled.");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("Location permission denied.");
      }
    }

    return await location.getLocation();
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help Request"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Enter Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _requestHelp,
                  child: Text("Send My Location"),
                ),
          ],
        ),
      ),
    );
  }
}
