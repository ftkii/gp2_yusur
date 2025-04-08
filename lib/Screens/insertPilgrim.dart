import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class InsertPilgrim extends StatefulWidget {
  const InsertPilgrim({super.key});

  @override
  _InsertPilgrimState createState() => _InsertPilgrimState();
}

class _InsertPilgrimState extends State<InsertPilgrim> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> insertPilgrim() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please register with all information')),
      );
      return;
    }

    String email = '${name.replaceAll(' ', '').toLowerCase()}@example.com';
    String password = generatePassword();

    var url = Uri.parse('https://code-builders.space/fluttertest/insert_pilgrim.php');
    var response = await http.post(
      url,
      body: {
        'campaign_name': 'Default Campaign',
        'admin_name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        showSuccessDialog(name, phone, email, password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${jsonResponse['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ في الاتصال بالخادم')),
      );
    }
  }

  String generatePassword({int length = 8}) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(
      List.generate(length, (index) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  void showSuccessDialog(String name, String phone, String email, String password) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("User has been registered successfully"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCopyRow("👤 Name:", name),
              buildCopyRow("📞 Phone:", phone),
              buildCopyRow("📧 E-Mail:", email),
              buildCopyRow("🔑 Password:", password),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("ok"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget buildCopyRow(String label, String value) {
    return Row(
      children: [
        Expanded(child: Text("$label $value")),
        IconButton(
          icon: const Icon(Icons.copy, size: 18),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('The data has been copied')),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Add a pilgrim",
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Image.asset(
                'images/insertpilgrim.png',
                width: 200,
                height: 200,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 412,
              height: 600,
              decoration: const BoxDecoration(
                color: Color(0x9A918580),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  topRight: Radius.circular(75),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Color(0xFF9A9185)),
                        ),
                        labelText: 'pilgrim name',
                        labelStyle: TextStyle(color: Color(0xFF9A9185)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Color(0xFF9A9185)),
                        ),
                        labelText: 'Phone',
                        labelStyle: TextStyle(color: Color(0xFF9A9185)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: insertPilgrim,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9A9185),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
