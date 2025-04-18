import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'create_incident_screen.dart';

class CurrentIncidentScreen extends StatefulWidget {
  final bool hasIncident;

  const CurrentIncidentScreen({super.key, required this.hasIncident});

  @override
  _CurrentIncidentScreenState createState() => _CurrentIncidentScreenState();
}

class _CurrentIncidentScreenState extends State<CurrentIncidentScreen> {
  late bool hasIncident;

  // 🟢 متغيرات تخزين بيانات الحادث
  String incidentNumber = "";
  String location = "";
  String numberOfInjured = "";
  String status = "";
  bool isLoading = true; // للتحكم في عرض مؤشر التحميل

  @override
  void initState() {
    super.initState();
    hasIncident = widget.hasIncident;
    if (hasIncident) {
      fetchIncidentDetails();
    }
  }

  // 🟢 دالة جلب بيانات الحادث من قاعدة البيانات
  Future<void> fetchIncidentDetails() async {
    String url =
        "https://code-builders.space/fluttertest/get_incident.php"; // 🔹 استبدل بالرابط الفعلي

    try {
      var response = await http.get(Uri.parse(url));
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data["status"] == "success" && data.containsKey("incident")) {
          setState(() {
            incidentNumber =
                data["incident"]["id"]; // 🔹 استخدم "id" بدلاً من "incident_number"
            location = data["incident"]["location"];
            numberOfInjured = data["incident"]["injured_count"];
            status =
                data["incident"]["category"]; // 🔹 قد تحتاج لتحديث "status" حسب نوع البيانات المتاحة
            isLoading = false;
            hasIncident = true;
          });
        } else {
          setState(() {
            hasIncident = false;
            isLoading = false;
          });
        }
      } else {
        _showMessage("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      _showMessage("Failed to connect to server: $e");
      setState(() {
        isLoading = false;
        hasIncident = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 العنوان
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    'Ambulance Request',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            // 🔹 أيقونة الإسعاف
            Center(
              child: Image.asset(
                'images/Ambulance.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 عرض تفاصيل الحادث أو رسالة "لا يوجد حادث"
            Expanded(
              child:
                  isLoading
                      ? const Center(
                        child: CircularProgressIndicator(),
                      ) // 🔄 مؤشر تحميل
                      : hasIncident
                      ? _buildIncidentDetails()
                      : _buildNoIncident(),
            ),
          ],
        ),
      ),
    );
  }

  // 🟢 عرض تفاصيل الحادث بعد جلب البيانات
  Widget _buildIncidentDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 380, maxHeight: 220),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFD1CCC4),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Incident Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              const Divider(color: Colors.black54),
              const SizedBox(height: 5),

              _buildDetailRow("Incident Number:", incidentNumber),
              _buildDetailRow("Location:", location),
              _buildDetailRow("Number of Injured:", numberOfInjured),
              _buildDetailRow("Status:", status),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    "Update",
                    const Color(0xFF9A9185),
                    Colors.black,
                    () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateIncidentScreen(),
                        ),
                      );

                      if (result != null && result is Map<String, String>) {
                        fetchIncidentDetails(); // 🔄 تحديث البيانات بعد التعديل
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildActionButton(
                    "Cancel",
                    const Color(0xFF9A9185),
                    Colors.black,
                    () {
                      setState(() {
                        hasIncident = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 تفاصيل كل عنصر
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label ",
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text:
                  value.isNotEmpty ? value : "N/A", // 🔹 تجنب عرض بيانات فارغة
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 زر الإجراءات (تحديث أو إلغاء)
  Widget _buildActionButton(
    String text,
    Color bgColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 في حال لم يكن هناك أي حادث
  Widget _buildNoIncident() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/no_incident.png', width: 80, height: 80),
        const SizedBox(height: 10),
        const Text(
          "There are no incidents",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
