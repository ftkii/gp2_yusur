import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'current_incident_screen.dart';

class CreateIncidentScreen extends StatefulWidget {
  @override
  _CreateIncidentScreenState createState() => _CreateIncidentScreenState();
}

class _CreateIncidentScreenState extends State<CreateIncidentScreen> {
  int injuredCount = 1;
  String selectedPerson = "I am the injured";
  String selectedCategory = "";
  String location = "Al Riyadh, 17364, Saudi Arabia";

  // 🟢 دالة لحفظ الحادث في قاعدة البيانات عبر PHP
  Future<void> saveIncident() async {
    String url =
        "https://code-builders.space/fluttertest/save_incident.php"; // استبدل بالرابط الفعلي

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "injured_person": selectedPerson,
          "location": location,
          "injured_count": injuredCount.toString(),
          "category": selectedCategory,
        },
      );

      var data = json.decode(response.body);
      if (data["status"] == "success") {
        // ✅ الانتقال إلى CurrentIncidentScreen عند نجاح الحفظ
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => const CurrentIncidentScreen(hasIncident: true),
          ),
        );
      } else {
        _showMessage("Error: ${data['message']}");
      }
    } catch (e) {
      _showMessage("Failed to connect to server");
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 زر الرجوع والعنوان
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        const Text(
                          'Ambulance Request',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 🔹 أيقونة سيارة الإسعاف
                    Center(
                      child: Image.asset(
                        'images/Ambulance.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      "Please complete the following steps to create the incident",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 اختيار المصاب
                    const Text(
                      "Who is the injured person?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildToggleButton("I am the injured"),
                        const SizedBox(width: 10),
                        _buildToggleButton("Another person"),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 🔹 اختيار الموقع
                    const Text(
                      "The incident location?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(location, "Edit"),

                    const SizedBox(height: 20),

                    // 🔹 اختيار عدد المصابين
                    const Text(
                      "The number?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildNumberSelector(),

                    const SizedBox(height: 20),

                    // 🔹 اختيار تصنيف الحادث
                    const Text(
                      "Incident category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.0,
                      children: [
                        _buildCategoryItem("Accidents", "images/accident.png"),
                        _buildCategoryItem("Diseases", "images/disease.png"),
                        _buildCategoryItem("Poisoning", "images/poison.png"),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // 🔹 زر الإرسال
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: saveIncident,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9A9185),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Submit Request",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedPerson = label;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedPerson == label ? Colors.blue : Colors.grey[300],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildTextField(String value, String action) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: TextButton(onPressed: () {}, child: Text(action)),
      ),
    );
  }

  Widget _buildNumberSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (injuredCount > 1) injuredCount--;
            });
          },
        ),
        Text("$injuredCount", style: const TextStyle(fontSize: 18)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              injuredCount++;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, String image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedCategory == title ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, width: 40, height: 40),
            const SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }
}
