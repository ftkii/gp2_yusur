import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart'; // استيراد geocoding
import 'request_details_screen.dart';

class RequestsListScreen extends StatefulWidget {
  @override
  _RequestsListScreenState createState() => _RequestsListScreenState();
}

class _RequestsListScreenState extends State<RequestsListScreen> {
  List<dynamic> _requests = [];
  Map<int, String> _locationsMap = {}; // تخزين العناوين بعد تحويلها
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRequests();
  }

  Future<void> _fetchRequests() async {
    final url = Uri.parse("https://code-builders.space/fluttertest/get_requests.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData["status"] == "success") {
        setState(() {
          _requests = responseData["requests"];
          _isLoading = false;
        });
        _convertAllCoordinates(); // تحويل جميع الإحداثيات بعد استلام البيانات
      } else {
        setState(() {
          _isLoading = false;
        });
        _showError(responseData["message"] ?? "Failed to load requests");
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showError("Failed to connect to server.");
    }
  }

  Future<void> _convertAllCoordinates() async {
    for (int i = 0; i < _requests.length; i++) {
      final locationString = _requests[i]["location"];
      if (locationString != null && locationString.contains(",")) {
        List<String> coords = locationString.split(",");
        if (coords.length == 2) {
          double? latitude = double.tryParse(coords[0]);
          double? longitude = double.tryParse(coords[1]);

          if (latitude != null && longitude != null) {
            try {
              List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
              if (placemarks.isNotEmpty) {
                Placemark place = placemarks[0];
                setState(() {
                  _locationsMap[i] = "${place.street}, ${place.locality}, ${place.country}";
                });
              }
            } catch (e) {
              setState(() {
                _locationsMap[i] = "Address not found";
              });
            }
          }
        }
      } else {
        setState(() {
          _locationsMap[i] = "Invalid location";
        });
      }
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
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
      appBar: AppBar(
        title: Text("Help Requests"),
        backgroundColor: Color(0xFF9A9185),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final request = _requests[index];
          final locationText = _locationsMap.containsKey(index)
              ? _locationsMap[index]
              : "Loading..."; // إظهار العنوان أو رسالة التحميل

          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text(request["user_name"], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(locationText ?? "Unknown location"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestDetailsScreen(request: request),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
