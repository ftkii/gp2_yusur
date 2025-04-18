import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class RequestDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> request;

  RequestDetailsScreen({required this.request});

  @override
  _RequestDetailsScreenState createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  String _locationAddress = "Loading...";

  @override
  void initState() {
    super.initState();
    _convertCoordinatesToAddress();
  }

  Future<void> _convertCoordinatesToAddress() async {
    if (widget.request["location"] != null) {
      List<String> coords = widget.request["location"].split(",");
      if (coords.length == 2) {
        double latitude = double.tryParse(coords[0]) ?? 0.0;
        double longitude = double.tryParse(coords[1]) ?? 0.0;

        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            latitude,
            longitude,
          );
          if (placemarks.isNotEmpty) {
            Placemark place = placemarks[0];
            setState(() {
              _locationAddress =
                  "${place.street}, ${place.locality}, ${place.country}";
            });
          } else {
            setState(() {
              _locationAddress = "Address not found";
            });
          }
        } catch (e) {
          setState(() {
            _locationAddress = "Error retrieving address";
          });
        }
      } else {
        setState(() {
          _locationAddress = "Invalid coordinates";
        });
      }
    } else {
      setState(() {
        _locationAddress = "No location provided";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Details"),
        backgroundColor: Color(0xFF9A9185),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.help_outline,
                    size: 80,
                    color: Color(0xFF9A9185),
                  ),
                ),
                SizedBox(height: 20),
                _buildDetailRow("User Name:", widget.request["user_name"]),
                SizedBox(height: 10),
                _buildDetailRow(
                  "Location:",
                  _locationAddress,
                ), // تم التعديل هنا
                SizedBox(height: 10),
                _buildDetailRow(
                  "Request Time:",
                  widget.request["created_at"] ?? "N/A",
                ),
                SizedBox(height: 20),
                _buildDetailRow("Request status:", widget.request["status"]),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9A9185),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text("Back", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
