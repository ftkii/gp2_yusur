import 'package:flutter/material.dart';
import 'package:yusur_app/widget/InfoBottomSheet.dart';
import 'package:yusur_app/widget/arrow.dart';

class QiblaDirectionScreen extends StatelessWidget {
  const QiblaDirectionScreen({super.key});

  final double qiblaAngle = 0; // زاوية القبلة (يمكن تعديلها لاحقًا)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Qibla Direction",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16, top: 16),
              child: ArrowIcon(),
            ),
          ],
          leading: // زر المعلومات (i)
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffffD9D9D9),
                  width: 0.5,
                ),
                color: Color.fromARGB(255, 241, 238, 238),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(Icons.info_outline, color: Colors.black),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => const InfoBottomSheet(
                      description:
                          "1. Hold your phone flat and steady in your hand. \n"
                          "2. Make sure to avoid any magnetic interference.\n"
                          "3. Follow the pointer until it aligns with the Kaaba icon.\n"
                          "4. The displayed angle (e.g., 294) indicates the Qibla direction.\n",
                    ),
                  );
                },
              ),
            ),
          )),
      body: ListView(
        children: [
          SizedBox(height: 150),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // العنوان
              const Text(
                "Qibla Direction",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // المنطقة
              const Text(
                "-- Region",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),

              // زاوية القبلة
              Text(
                "$qiblaAngle°",
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // دائرة فارغة للقبلة
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
