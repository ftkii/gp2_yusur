import 'package:flutter/material.dart';

//  (Bottom Sheet)
class InfoBottomSheet extends StatelessWidget {
  final String description;
  const InfoBottomSheet({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // أيقونة الهاتف
              Image.asset(
                'images/phone.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),

              // عنوان "How to use"
              const Text(
                "How to use",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // التعليمات
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),

        // خط فاصل فوق الزر
        const Divider(
          thickness: 0.5,
          height: 1,
          color: Colors.black,
        ),

        // زر الإغلاق مثل Figma
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: const Text(
              "Close",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
