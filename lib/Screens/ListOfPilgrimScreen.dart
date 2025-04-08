import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'edit_pilgrim_screen.dart';

class ListOfPilgrimScreen extends StatefulWidget {
  const ListOfPilgrimScreen({super.key});

  @override
  _ListOfPilgrimScreenState createState() => _ListOfPilgrimScreenState();
}

class _ListOfPilgrimScreenState extends State<ListOfPilgrimScreen> {
  List<dynamic> pilgrims = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPilgrims();
  }

  Future<void> fetchPilgrims() async {
    final url = Uri.parse("https://code-builders.space/fluttertest/get_pilgrim.php");

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData["success"] == true) {
        setState(() {
          pilgrims = responseData["users"];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showError(responseData["message"] ?? "Failed to load pilgrims");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _showError("Failed to connect to server.");
    }
  }

  Future<void> deletePilgrim(int id) async {
    final url = Uri.parse("https://code-builders.space/fluttertest/delete_pilgrim.php");

    try {
      final response = await http.post(url, body: {"id": id.toString()});

      print("🟢 Server Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData["success"] == true) {
          setState(() {
            pilgrims.removeWhere((pilgrim) => pilgrim["id"] == id);
          });
        } else {
          _showError(responseData["message"] ?? "Failed to delete pilgrim");
        }
      } else {
        _showError("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error deleting pilgrim: $e");
      _showError("An error occurred: $e");
    }
  }


  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.black)),
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "List of Pilgrims",
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: pilgrims.length,
        itemBuilder: (context, index) {
          final pilgrim = pilgrims[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListTile(
              leading: Image.asset('images/yusur_logo.png', height: 40, width: 40),
              title: Text(pilgrim["admin_name"], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(pilgrim["phone"]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPilgrimScreen(pilgrim: pilgrim),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),

    onPressed: () {
    int pilgrimId = int.tryParse(pilgrim["id"].toString()) ?? 0; // ✅ تحويل آمن
    if (pilgrimId > 0) {
    deletePilgrim(pilgrimId);
    } else {
    _showError("Invalid pilgrim ID");
    }}
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
