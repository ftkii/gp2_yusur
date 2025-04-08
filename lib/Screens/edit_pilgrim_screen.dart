import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPilgrimScreen extends StatefulWidget {
  final Map<String, dynamic> pilgrim;

  const EditPilgrimScreen({super.key, required this.pilgrim});

  @override
  _EditPilgrimScreenState createState() => _EditPilgrimScreenState();
}

class _EditPilgrimScreenState extends State<EditPilgrimScreen> {
  final TextEditingController campaignNameController = TextEditingController();
  final TextEditingController adminNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    campaignNameController.text = widget.pilgrim["campaign_name"] ?? "";
    adminNameController.text = widget.pilgrim["admin_name"] ?? "";
    phoneController.text = widget.pilgrim["phone"] ?? "";
    emailController.text = widget.pilgrim["email"] ?? "";
    passwordController.text = widget.pilgrim["password"] ?? "";
  }

  Future<void> updatePilgrim() async {
    final url = Uri.parse("https://code-builders.space/fluttertest/update_pilgrim.php");

    // ✅ طباعة البيانات قبل الإرسال للتأكد من عدم وجود قيم فارغة
    print("Sending data: id=${widget.pilgrim["id"]}, campaign_name=${campaignNameController.text}, admin_name=${adminNameController.text}, phone=${phoneController.text}, email=${emailController.text}, password=${passwordController.text}");

    final response = await http.post(url, body: {
      "id": widget.pilgrim["id"].toString(),
      "campaign_name": campaignNameController.text.trim(),
      "admin_name": adminNameController.text.trim(),
      "phone": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    });

    print("Response: ${response.body}");

    final responseData = json.decode(response.body);

    if (response.statusCode == 200 && responseData["success"] == true) {
      Navigator.pop(context, true);
    } else {
      _showError(responseData["message"] ?? "Failed to update pilgrim");
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Pilgrim")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: campaignNameController, decoration: const InputDecoration(labelText: "Campaign Name")),
            TextField(controller: adminNameController, decoration: const InputDecoration(labelText: "Admin Name")),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updatePilgrim,
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
